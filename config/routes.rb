Rails.application.routes.draw do  
  devise_for :users
  root "short_links#home"
  post "/", to: 'short_links#home', as: 'short_link_home' 
  get '/:short_link', to: 'short_links#home', as: 'short_link_redirect'
end
