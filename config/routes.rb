SkylineDemoSite::Application.routes.draw do
  resources :orders
  resources :rss, :only => :show
  
  match '(*url)', :to => "pages#show", :constraints => Skyline::RouteConstraint
end

