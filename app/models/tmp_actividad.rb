class TmpActividad < ActiveRecord::Base
  belongs_to :proyecto, :class_name => 'TmpProyecto', :foreign_key => 'proyecto_id'
  attr_accessible :complejidad, :estado, :funcionalidad, :modulo, :proyecto_id, :revision
end
