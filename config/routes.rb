Rails.application.routes.draw do
  devise_for :users
  root to: 'rewards#index'
  resources :rewards
  resources :goals, only: [:edit, :update]
  resources :favorites, only: [:create]
  resources :cheerings, only: [:create]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener" 
  end
end
