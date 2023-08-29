Rails.application.routes.draw do  
  root "static_pages#Home" # Use lowercase 'home' for consistency
  post "/", to: 'static_pages#Home', as: 'static_pages_home' # Post route for root path
  get '/:short_link', to: 'short_links#redirect', as: 'short_link_redirect'
  get 'static_pages/about', to: 'static_pages#about', as: 'static_pages_about' # Use lowercase 'about' for consistency
end
