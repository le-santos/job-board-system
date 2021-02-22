Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :candidates
  resources :candidates, only: %i[ show edit update ] do 
    post 'apply', on: :member
  end

  devise_for :employees, path: 'employees'

  #FIXME rota jobs#create deveria dentro de company, mas não funcionou
  resources :companies, only: %i[ index show edit update ] do
    resources :jobs, only: %i[ index new ] 
  end
  
  resources :jobs, only: %i[ index show create edit update ]
end
