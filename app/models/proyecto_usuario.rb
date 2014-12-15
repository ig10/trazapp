class ProyectoUsuario < ActiveRecord::Base
  attr_accessible :usuario_id, :proyecto_id
  belongs_to :usuario
  belongs_to :proyecto
end