Rails.application.routes.draw do
  root to: 'home#index'

  resources :companies, only: %i[ index show ] do
    resources :jobs, only: %i[ show ]
  end
end
