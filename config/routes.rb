Rails.application.routes.draw do

  resources :webpages
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :blogs do
    collection do
      post :confirm
    end
  end
  
  root 'sessions#new'

  resources :favorites, only: [:create, :destroy, :index]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
