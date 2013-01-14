require 'sidekiq/web'
Mediashare::Application.routes.draw do

  devise_for :users, :controllers => {:sessions => 'sessions'}
  resources :users

  match 'media/allmedia', :to => 'media#allmedia'
  resources :media

  match 'mediafiles/index.json', :to => 'mediafiles#jsonindex'
  match 'mediafiles/insert.json', :to => 'mediafiles#insert'
  match 'mediafiles/pending', :to => 'mediafiles#pending'
  match 'mediafiles/destroyall.json', :to => 'mediafiles#destroyall'

  resources :mediafiles

  match ':controller(/:action(/:id(.:format)))'

  root :to => 'home#index'

  constraint = lambda { |request| request.env["warden"].authenticate? and request.env['warden'].user.has_role? "admin" }
  constraints constraint do
    mount Sidekiq::Web => '/sidekiq'
  end

end
