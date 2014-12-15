# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
#
# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'tmp_actividad', 'tmp_actividades'
  inflect.irregular 'actividad', 'actividades'
  inflect.irregular 'configuracion', 'configuraciones'
  inflect.irregular 'seccion', 'secciones'
  inflect.irregular 'seccion_usuario', 'secciones_usuarios'
  inflect.irregular 'solicitud_usuario', 'solicitudes_usuarios'
  inflect.irregular 'proyecto_usuario', 'proyectos_usuarios'
  inflect.irregular 'tmp_proyecto_usuario', 'tmp_proyectos_usuarios'
end
