BlocipediaExample::Application.routes.draw do
  get "statics/show"
  devise_for :users
  root to: 'statics#show'
end
