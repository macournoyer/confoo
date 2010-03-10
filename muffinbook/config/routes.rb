ActionController::Routing::Routes.draw do |map|
  map.resources :recipes, :collection => { :random => :get }
  
  map.root :controller => "recipes"
end
