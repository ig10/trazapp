class SeccionUsuario < ActiveRecord::Base
  attr_accessible :usuario_id, :seccion_id
  belongs_to :usuario
  belongs_to :seccion
end