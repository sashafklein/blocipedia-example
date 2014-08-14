BlocipediaExample::Application.routes.draw do

  resources :wikis, except: [:index] do
    resources :collaborators, only: :index
    resources :users, only: [] do
      resources :collaborations, only: [:create, :destroy]
    end
  end

  resources :charges, only: [:new, :create]
  
  resources :users, only: [] do
    get :owned_wikis, on: :member
    get :collaborated_wikis, on: :member
  end

  devise_for :users
  
  root to: 'statics#show'
end
