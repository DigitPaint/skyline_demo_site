# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Generate a title tag for a page
  # --
  def title_tag(page)
    if @skip_title && @bread_crumb
      title = @bread_crumb[-1][0]
    else
      title = page.data.title_tag
    end
    [title, Skyline::Page.root.andand.published_publication_data.andand.title].uniq.join(" - ")
  end
  
  # Generate a meta description tag for a page
  # --
  def meta_description_tag(page)
    if page.data.meta_description_tag.present?
      page.data.meta_description_tag
    else
      tag = strip_tags(page.to_text)
      if r = tag.match(/^([^\.]*)\./)
        tag = r[1] + "."
      end
      tag[0..180]
    end
  end  
  
  def site_map(nodes,options_for_root={})
    nodes = Array(nodes)
    
    lis = nodes.map do |node|
      next unless node[:page].published?
      content = link_to node[:page].published_publication_data.navigation_title, node[:page].url
      content << site_map(node[:children]) if node[:children].present?
      content_tag("li",content)
    end
    
    content_tag("ul",lis.join("\n"), options_for_root)
  end
end
