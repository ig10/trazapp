Trazapp::Application.routes.draw do
  resources :tmp_actividades
  resources :tmp_proyectos
  resources :proyectos
  resources :usuarios
  resources :actividades
  resources :tareas

  root to: 'public#index'

  match '/alumnos' => 'alumnos#index'

  # Modify this routes considering new views in Teacher's admin Panel
  match '/profesor' => 'profesores#index'

  match '/solicitudes' => 'tmp_proyectos#index'
  match '/activos' => 'proyectos#index'
  match '/reportes' => 'reportes#index'
  match '/reporte_general' => 'reportes#reporte_general'
  match '/login' => 'public#login'
  # match '/configuraciones' => 'configuraciones#index'
  scope '/configuraciones', controller: 'configuraciones' do
    match '/', action: 'index'
    post '/load_students', action: 'load_students'
  end

  match '/tmp_proyectos' => 'tmp_proyectos#create'
  match '/tmp_proyectos/:id' => 'tmp_proyectos#update'

  scope 'solicitud' do
    match 'nuevo' => 'tmp_proyectos#new'
    match 'editar/:id/:codigo_acceso' => 'tmp_proyectos#edit'
    match 'eliminar/:id/:codigo_acceso' => 'tmp_proyectos#destroy'
    match 'aprobar/:id/:codigo_acceso' => 'tmp_proyectos#aprobar'
  end

  scope 'proyecto' do
    match 'nuevo' => 'proyectos#new'
    match 'editar/:id/:codigo_acceso' => 'proyectos#edit'
    match 'eliminar/:id/:codigo_acceso' => 'proyectos#destroy'
    scope 'actividad' do
      match ':id/:codigo_acceso/:actividad' => 'actividades#index'
      match 'eliminar/:id/:codigo_acceso/:actividad' => 'actividades#destroy'
      match ':id/:codigo_acceso/nueva-tarea/:actividad' => 'actividades#nueva_tarea'
    end
  end

  #Enviar Mail Codigo Acceso
  match '/enviar-codigo' => 'application#enviar_codigo'
end
