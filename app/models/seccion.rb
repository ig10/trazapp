class Seccion < ActiveRecord::Base
  attr_accessible :id, :jornada, :nombre, :sigla
  has_and_belongs_to_many :usuarios

  def self.to_hash
    Hash[ self.includes(:usuarios).
      all.map{ |s| [s.sigla, s.usuarios.map{ |u| [u.id, u.nombre_completo, u.rut] }] }]
  end

end
