Mediashare::Application.routes.draw do

  resources :media

  match 'admin', :to => 'access#menu'

  match 'login.json', :to => 'access#jsonlogin'

  match 'logout.json', :to => 'access#jsonlogout'

  match 'mediafiles/index.json', :to => 'mediafiles#jsonindex'

  match 'mediafiles/insert.json', :to => 'mediafiles#insert'

  resources :mediafiles

   match ':controller(/:action(/:id(.:format)))'

end
