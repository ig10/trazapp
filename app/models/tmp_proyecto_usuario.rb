class TmpProyectoUsuario < ActiveRecord::Base
  attr_accessible :usuario_id, :tmp_proyecto_id
  belongs_to :usuario
  belongs_to :tmp_proyecto
end