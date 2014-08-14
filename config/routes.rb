BlocipediaExample::Application.routes.draw do
  
  get "users/owned_wikis"
  get "users/collaborated_wikis"
  resources :wikis, except: [:index]
  
  resources :users, only: [] do
    get :owned_wikis, on: :member
    get :collaborated_wikis, on: :member
  end

  get "statics/show"
  devise_for :users
  
  root to: 'statics#show'
end
