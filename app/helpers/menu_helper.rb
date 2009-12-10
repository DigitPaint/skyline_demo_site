module MenuHelper
  
  # Check to see if submenu should be shown
  # 
  # ==== Parameters
  # page<Page>:: Current page
  #
  # ==== Options
  # :level<Integer>:: Starting level for (default = 1)
  #
  # ==== Returns true if :level of page has children
  def show_submenu?(page, options={})
    options.reverse_merge! :level => 1
    level = options[:level]
    
    menu(page.nesting[level])[:children].any?
  end
  
  # Create a menu structure starting at a certain page 
  # 
  # ==== Parameters
  # page<Page>:: Startpoint for menu
  #
  # ==== Options
  # :depth<Integer>:: Depth for menu (default = 1)
  #
  # --
  def menu(page,options={})
    options.reverse_merge! :depth => 1
    depth = options[:depth]
    
    base = {:page => page, :children => []}
    return base if options[:depth] == 0
        
    base[:children] = page.children.in_navigation.published.map{|child| menu(child,:depth => (depth - 1))}
    base
  end
  
end