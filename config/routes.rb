Trazapp::Application.routes.draw do
  resources :tmp_actividades
  resources :tmp_proyectos
  resources :proyectos
  resources :usuarios
  resources :actividades
  resources :tareas

  root to: redirect('/login')

  scope controller: 'sessions' do
    get '/login', action: 'new'
    post '/login', action: 'create'
    match '/logout', action: 'destroy'
  end

  match '/alumnos' => 'alumnos#index'
  match '/profesor' => 'profesores#index'

  match '/solicitudes' => 'tmp_proyectos#index'
  match '/activos' => 'proyectos#index'


  match '/reportes' => 'reportes#index'
  match '/reporte_general' => 'reportes#reporte_general'

  scope '/configuraciones', controller: 'configuraciones' do
    match '/', action: 'index'
    post '/load_students', action: 'load_students'
    post '/load_structure', action: 'load_structure'
  end

  match '/tmp_proyectos' => 'tmp_proyectos#create'
  match '/tmp_proyectos/:id' => 'tmp_proyectos#update'

  scope 'solicitud', controller: 'tmp_proyectos' do
    match 'nuevo', action: 'new'
    match 'editar/:id/:codigo_acceso', action: 'edit'
    match 'eliminar/:id/:codigo_acceso', action: 'destroy'
    match 'aprobar/:id/:codigo_acceso', action: 'aprobar'
  end

  scope 'proyecto', controller: 'proyectos' do
    match 'nuevo', action: 'new'
    match 'editar/:id/:codigo_acceso', action: 'edit'
    match 'eliminar/:id/:codigo_acceso', action: 'destroy'
    scope 'actividad', controller: 'actividades' do
      match ':id/:codigo_acceso/:actividad', action: 'index'
      match 'eliminar/:id/:codigo_acceso/:actividad', action: 'destroy'
      match ':id/:codigo_acceso/nueva-tarea/:actividad', action: 'nueva_tarea'
    end
  end

  #Enviar Mail Codigo Acceso
  match '/enviar-codigo' => 'application#enviar_codigo'
end
