Rails.application.routes.draw do  
  root "static_pages#Home"
  post "static_pages/Home", to: 'static_pages#Home', as: 'static_pages_home'
  get '/:short_link', to: 'short_links#redirect', as: 'short_link_redirect'
  get 'static_pages/About'
end
