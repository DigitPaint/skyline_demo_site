ActionController::Routing::Routes.draw do |map|
  map.resource :order
  map.connect 'orders/:action', :controller => "orders"
  
  map.rss 'rss/:model.:format', :controller => "rss", :action => "show"
  map.form_response '*url/response/:action', :controller => "skyline/site/responses"
  
  # Default pages renderer.
  map.connect '*url', :controller => "pages", :action => "show"
end
