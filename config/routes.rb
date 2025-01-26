Rails.application.routes.draw do
  devise_scope :user do
    root to: 'users/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # devise_for :users
  devise_for :users, controllers: { invitations: 'users/invitations' }
  resources :users, only: [:index, :show]
  resources :rewards
  resources :goals

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener" 
  end
end
