Rails.application.routes.draw do

resources :movies
resources :directors
  #root "movies#index"
  get "/" => "home#index"


end