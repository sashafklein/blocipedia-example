BlocipediaExample::Application.routes.draw do

  resources :wikis, except: [:index]

  resources :charges, only: [:new, :create]
  
  resources :users, only: [] do
    get :owned_wikis, on: :member
    get :collaborated_wikis, on: :member
  end

  devise_for :users
  
  root to: 'statics#show'
end
