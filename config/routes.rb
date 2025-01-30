Rails.application.routes.draw do
  devise_for :users
  root to: 'rewards#index'
  resources :rewards
  resources :goals, only: [:edit, :update]
  resources :favorites, only: [:update]
  resources :cheerings, only: [:update]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener" 
  end
end
