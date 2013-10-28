Trazapp::Application.routes.draw do
  resources :tmp_actividades
  resources :tmp_proyectos
  resources :usuarios

  root to: 'public#index'

  match '/alumnos' => 'tmp_proyectos#new'
  match '/profesor' => 'tmp_proyectos#index'
  match '/tmp_proyectos' => 'tmp_proyectos#create'
  match '/proyecto/editar/:id' => 'tmp_proyectos#edit'
  match '/tmp_proyectos/:id' => 'tmp_proyectos#update'
end
