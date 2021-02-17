Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :candidates
  resources :candidates, only: %i[ show edit update ]

  resources :companies, only: %i[ index show ] do
    resources :jobs, only: %i[ index ]
  end
  
  resources :jobs, only: %i[ index show ] do
    post 'apply', on: :member
  end
  
end
