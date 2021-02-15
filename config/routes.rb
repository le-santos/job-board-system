Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :candidates

  resources :companies, only: %i[ index show ] do
    resources :jobs, only: %i[ show ]
  end
end
