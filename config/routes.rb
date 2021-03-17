Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :candidates
  resources :candidates, only: %i[ show edit update ] do 
    post 'apply', on: :member
    get 'job_applications', on: :member
  end

  devise_for :employees, path: 'employees'

  resources :companies, only: %i[ index show edit update ] do
    resources :jobs, only: %i[ index new ]
    get 'job_applications', on: :member
  end
  
  resources :job_applications, only: %i[ edit update ] do
    resources :offers, only: %i[ new create show ] do
      member do
        post 'accept'
        post 'decline'
      end
    end
  end

  resources :jobs, only: %i[ index show create edit update ] do
    post 'inactivate', on: :member
  end

  namespace 'api', defaults: {format: :json} do
    namespace 'v1' do
      resources 'jobs', only: %i[index]
      resources 'companies', only: %i[index]
    end
  end
end
