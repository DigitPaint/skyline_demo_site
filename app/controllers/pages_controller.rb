class PagesController < Skyline::Site::PagesController
  
  def show
    renderer = @site.renderer(:controller => self)
    
    if @page_version      
      renderer.assigns[:bread_crumb] = @page_version.page.nesting.map{|p| [p.published_publication_data.navigation_title,p.url] }
      renderer.assigns[:skip_title] = false
      renderer.assigns[:search_active] = (Settings.get(:specials, :sitemap_page_id).present? && Skyline::Configuration.solr_indexing)
      
      # =================
      # = Searchresults =
      # =================
      if @page_version.page.id == Settings.get(:search, :results_page_id).andand.to_i && @url_parts.empty?
        if solr = connect_to_solr
          if params[:q].present?          
            q = "*:*"
            fq = []
            if params[:search_type] == "files"
              fq << "{!tag=cat}cat:\"#{escape_special_chars('Skyline::MediaFile')}\""
            else 
              fq << "{!tag=cat}!cat:\"#{escape_special_chars('Skyline::MediaFile')}\""            
            end
            q = escape_special_chars(params[:q])
            
            paginate_page = params[:page].present? ? params[:page] : 1
            
            solr_params = RSolr::Ext.map_params(
              :q => q, 
              :fq => fq, 
              :hl => true, 
              "hl.fl" => "text", 
              "spellcheck.q" => params[:q], 
              :spellcheck => true, 
              "spellcheck.build" => true, 
              :facet => "on", 
              "facet.field" => "{!ex=cat}cat",
              :page => paginate_page,
              :per_page => 10
            )
            
            raw_response = solr.spellCheckCompRH(solr_params)
            
            response = RSolr::Ext.wrap_response(raw_response)
            
            count_results = response["facet_counts"]["facet_fields"]["cat"].in_groups_of(2).inject({}) do |result, element|
              result[element.first] = element.last.to_i
              result
            end
                      
            total_found = count_results.sum{|k, v| v}
                                          
            files_found = count_results["Skyline::MediaFile"].present? ? count_results["Skyline::MediaFile"] : 0
            
            pages_found = total_found - files_found
            
            results = response['response']['docs']
            
            hl = response['highlighting']
            suggestions = response['spellcheck'] ? response['spellcheck']['suggestions'] : []
          else
            suggestions = []
            results = []
          end
          
          if params[:search_type] == "files"
            search_results = render_to_string :partial => 'search/index_files', :locals => {:results => results, :hl => hl, :suggestions => suggestions, :search_term => params[:q], :pages_found => pages_found, :files_found => files_found}          
          else
            search_results = render_to_string :partial => 'search/index', :locals => {:results => results, :hl => hl, :suggestions => suggestions, :search_term => params[:q], :pages_found => pages_found, :files_found => files_found}
          end
            
          searchtype = 'extended'
        else
          searchtype = nil
          search_results = render_to_string :partial => 'search/error'
        end
        renderer.assigns[:skip_title] = true        
        renderer.assigns.update(:body => search_results, :search_type => searchtype)
      end
            
      # ============
      # = Newsitem =
      # ============
      if @page_version.page.id == Settings.get(:content, :news_item_detail_page_id).andand.to_i && @url_parts.any?
        @news_item = NewsItem.find_by_url_part(@url_parts.join("/")).andand.published_publication
        if @news_item
          renderer.assigns.update(:renderable_object => @news_item)
        end
      end      
      
      # ===========
      # = Sitemap =
      # ===========
      
      if @page_version.page.id == Settings.get(:specials, :sitemap_page_id).andand.to_i 
        sitemap = render_to_string :partial => "pages/sitemap", :locals => {:root => Skyline::Page.root}
        renderer.assigns.update(:body => sitemap)
      end
                      
      # ========
      # = Page =
      # ========
      if renderer.assigns[:body].blank? && renderer.assigns[:renderable_object].blank? && @url_parts.empty?
        renderer.assigns.update(:body => self.response.body)
      end
      
      logger.warn "===========> #{renderer.assigns.inspect}"
      
      render :text => renderer.render(@page_version) if renderer.assigns[:body].present? || renderer.assigns[:renderable_object].present?
    end    

    # ================================================
    # = Fallback; render 404 if nothing was rendered =
    # ================================================
    self.handle_404 unless performed?
  end
  
  
  protected

  def handle_404
    page_id = Settings[:specials].error404_page_id.to_i
    if page_version = Skyline::Page.find_by_id(page_id).andand.published_publication
      render :text => @site.renderer(:controller => self).render(page_version), :status => :not_found
    else
      render :text => "Error 404 :: Page with url \"#{params[:url].join("/")}\" doesn't exist.", :status => :not_found    
    end
  end

  def escape_special_chars(str)
    # From: http://lucene.apache.org/java/2_4_0/queryparsersyntax.html#Escaping%20Special%20Characters
    # Lucene supports escaping special characters that are part of the query syntax. The current list special characters are
    #      + - && || ! ( ) { } [ ] ^ " ~ * ? : \
    # To escape these character use the \ before the character. For example to search for (1+1):2 use the query:
    #      \(1\+1\)\:2

    str.gsub(/([\+\-\!\(\)\]\[\^\"\~\*\?\:\\]|(&&)|(\|\|))/, '\\\\\1')
  end
  helper_method :escape_special_chars
  
  def connect_to_solr
    begin
      solr = RSolr.connect
      solr.send_request('/admin/ping')
    rescue RSolr::RequestError => e
      ErrorMailer.deliver_exception(e, "Solr not running") if Rails.env == 'production'
      solr = false
    end
    solr
  end
  
  def possibly_redirect
    return unless @page_version
    if redirect_section = @page_version.sections.detect{|section| section.sectionable.kind_of?(Skyline::Sections::RedirectSection)}
      if redirect_section.sectionable.delay == 0
        redirect_to redirect_section.sectionable.url(request)
      end
    end
  end
end
