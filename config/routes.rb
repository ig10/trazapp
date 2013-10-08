Trazapp::Application.routes.draw do
  resources :tmp_actividades
  resources :tmp_proyectos
  resources :usuarios

  root to: 'public#index'

  match '/alumnos' => 'tmp_proyectos#new'
  match '/profesor' => 'tmp_proyectos#index'

end
