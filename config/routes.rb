require 'sidekiq/web'
Mediashare::Application.routes.draw do

  devise_for :users, :controllers => {:sessions => 'sessions'}
  resources :users

  resources :media

  match 'mediafiles/index.json', :to => 'mediafiles#jsonindex'
  match 'mediafiles/insert.json', :to => 'mediafiles#insert'
  match 'mediafiles/pending', :to => 'mediafiles#pending'

  resources :mediafiles

  match ':controller(/:action(/:id(.:format)))'
  root :to => "mediafiles#index"

  mount Sidekiq::Web, at: "/sidekiq"

end
