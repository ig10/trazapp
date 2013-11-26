class Tarea < ActiveRecord::Base
  belongs_to :actividad, class_name: 'Actividad', foreign_key: 'actividad_id'
  attr_accessible :actividad_id, :descripcion, :estado, :evaluacion, :revision

  before_create :setear_revision

  def setear_revision
    self.revision = self.actividad.revision
  end



end
