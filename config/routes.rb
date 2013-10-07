Trazapp::Application.routes.draw do
  resources :tmp_groups
  resources :users
  
  root to: 'public#index'
end
