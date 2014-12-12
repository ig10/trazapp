class SolicitudUsuario < ActiveRecord::Base
  attr_accessible :usuario_id, :solicitud_id
  belongs_to :usuario
  belongs_to :solicitud
end