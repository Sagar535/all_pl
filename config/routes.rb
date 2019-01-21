Rails.application.routes.draw do
  resources :p_languages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'p_languages/upload', to: 'p_languages#upload'
  post 'p_languages/destroy_all', to: 'p_languages#destroy_all'
end
