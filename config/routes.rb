Trazapp::Application.routes.draw do
  resources :tmp_actividades
  resources :tmp_proyectos
  resources :proyectos
  resources :usuarios
  resources :actividades
  resources :tareas

  root to: redirect('/login')

  scope controller: 'sessions' do
    get '/login', action: 'new', as: :login
    post '/login', action: 'create'
    match '/logout', action: 'destroy', as: :logout
  end

  match '/alumnos' => 'alumnos#index'
  match '/profesor' => 'profesores#index'

  match '/solicitudes' => 'tmp_proyectos#index', as: :solicitudes
  match '/proyectos' => 'proyectos#index', as: :proyectos


  match '/reportes' => 'reportes#index', as: :reportes
  match '/reporte-general' => 'reportes#reporte_general'

  scope '/configuraciones', controller: 'configuraciones' do
    match '/', action: 'index', as: :configuraciones
    post '/load_students', action: 'load_students'
    post '/load_structure', action: 'load_structure'
  end

  # match '/tmp_proyectos' => 'tmp_proyectos#create'
  # match '/tmp_proyectos/:id' => 'tmp_proyectos#update'

  scope 'solicitud', controller: 'tmp_proyectos' do
    match 'nueva', action: 'new', as: :nueva_solicitud
    match 'crear', action: 'create', as: :crear_solicitud
    match 'editar/:id', action: 'edit', as: :editar_solicitud
    match 'eliminar/:id', action: 'destroy', as: :eliminar_solicitud
    post 'modificar/:id', action: 'update', as: :modificar_solicitud
    match 'aprobar/:id', action: 'aprobar', as: :aprobar_solicitud
  end

  scope 'proyecto', controller: 'proyectos' do
    match 'nuevo', action: 'new'
    match 'editar/:id', action: 'edit', as: :editar_proyecto
    match 'eliminar/:id', action: 'destroy', as: :eliminar_proyecto
    scope 'actividad', controller: 'actividades' do
      post 'evaluar/:id', action: 'evaluar', as: :evaluar_actividad
      match ':id/:actividad', action: 'index'
      match 'eliminar/:id/:actividad', action: 'destroy'
      match ':id/nueva-tarea/:actividad', action: 'nueva_tarea'
    end
  end

  scope 'actividad', controller: 'actividades' do
    match 'editar/:id', action: 'edit', as: :editar_actividad
  end
end
