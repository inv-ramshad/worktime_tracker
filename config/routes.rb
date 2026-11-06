Rails.application.routes.draw do
  get "dashboard/index"
  get "up" => "rails/health#show", as: :rails_health_check

  
  root "dashboard#index"

  resources :attendances, only: [:index] do
    collection do
      post :sign_in
    end

    member do
      patch :take_break
      patch :resume_work
      patch :sign_off
      patch :re_sign_in
    end
  end

  resources :pomodoro_sessions, only: [:index, :create]
  
end
