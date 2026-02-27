Rails.application.routes.draw do  
  devise_for :users, controllers: { registrations: 'users/registrations'}
  root "short_links#home"
  
  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  resources :short_links do
    resource :analytics, only: [:show]
  end
  
  post 'qr_download', to: 'short_links#qr_download', as: :qr_download
  
  get '/about', to: 'static_pages#about', as: 'about'
  get '/terms', to: 'static_pages#terms', as: 'terms_of_service'
  get '/profile', to: 'users#profile', as: 'user_profile'
  post "/", to: 'short_links#home', as: 'short_link_home' 
  get '/:short_link', to: 'short_links#home', as: 'short_link_redirect'
  

end
