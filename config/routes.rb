Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/goals')
  resources :rewards
  resources :goals, only: [:index, :edit, :update] do
    resources :favorites, only: [:update]
    resources :cheerings, only: [:update]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener" 
  end
end
