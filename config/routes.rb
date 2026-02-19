Rails.application.routes.draw do  
  devise_for :users, controllers: { registrations: 'users/registrations'}
  root "short_links#home"
  get '/about', to: 'static_pages#about', as: 'about'
  get '/terms', to: 'static_pages#terms', as: 'terms_of_service'
  get '/profile', to: 'users#profile', as: 'user_profile'
  post "/", to: 'short_links#home', as: 'short_link_home' 
  get '/:short_link', to: 'short_links#home', as: 'short_link_redirect'
end
