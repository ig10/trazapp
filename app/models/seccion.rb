class Seccion < ActiveRecord::Base
  attr_accessible :id, :jornada, :nombre, :sigla
  has_and_belongs_to_many :usuarios
  has_many :solicitudes, class_name: 'TmpProyecto', foreign_key: 'seccion_id'

  def self.to_hash
    Hash[ self.includes(:usuarios).
      all.map{ |s| [s.sigla, s.usuarios.map{ |u| [u.id, u.nombre_completo, u.rut] }] }]
  end

  def self.for_select
    self.all.map{|x| [x.sigla, x.id]}
  end

end
