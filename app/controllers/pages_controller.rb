class PagesController < Skyline::Site::PagesController
  
  def show
    renderer = @site.renderer(:controller => self)
    
    if @page_version      
      renderer.assigns[:bread_crumb] = @page_version.page.nesting.map{|p| [p.published_publication_data.navigation_title,p.url] }
      renderer.assigns[:skip_title] = false
            
      # ============
      # = Newsitem =
      # ============
      if @page_version.page.id == Settings.get(:content, :news_item_detail_page_id).andand.to_i && @url_parts.any?
        @news_item = NewsItem.find_by_url_part(@url_parts.join("/")).andand.published_publication
        if @news_item
          renderer.assigns.update(:renderable_object => @news_item)
        end
      end 
      
      # ========
      # = Shop =
      # ========
      if @page_version.page.id == Settings.get(:shop, :product_detail_page_id).andand.to_i && @url_parts.any?
        @product = Product.find_by_url_part(@url_parts.join("/")).andand.published_publication
        if @product
          renderer.assigns.update(:skip_sections => true)
          renderer.assigns.update(:renderable_object => @product)
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
    
  def possibly_redirect
    return unless @page_version
    if redirect_section = @page_version.sections.detect{|section| section.sectionable.kind_of?(Skyline::Sections::RedirectSection)}
      if redirect_section.sectionable.delay == 0
        redirect_to redirect_section.sectionable.url(request)
      end
    end
  end
end
