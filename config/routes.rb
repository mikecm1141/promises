Rails.application.routes.draw do
  root to: 'promises#index'

  resources :promises
end
