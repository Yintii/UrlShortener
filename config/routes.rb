Rails.application.routes.draw do  
  root "short_links#home"
  post "/", to: 'short_links#home', as: 'short_link_home' 
  get '/:short_link', to: 'short_links#home', as: 'short_link_redirect'
  get 'static_pages/about', to: 'static_pages#about', as: 'static_pages_about' 
end
