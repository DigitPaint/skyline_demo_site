ActionController::Routing::Routes.draw do |map|
  map.connect 'search_suggestions', :controller => "search_suggestions", :action => "index"
  
  map.rss 'rss/:model.:format', :controller => "rss", :action => "show"
  map.form_response '*url/response/:action', :controller => "skyline/site/responses"
  
  # Default pages renderer.
  map.connect '*url', :controller => "pages", :action => "show"
end
