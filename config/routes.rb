Mediashare::Application.routes.draw do

  devise_for :users
  resources :users

  resources :media

  match 'mediafiles/index.json', :to => 'mediafiles#jsonindex'

  match 'mediafiles/insert.json', :to => 'mediafiles#insert'

  resources :mediafiles

   match ':controller(/:action(/:id(.:format)))'
  root :to => "mediafiles#index"


end
