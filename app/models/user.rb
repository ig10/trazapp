class User < ActiveRecord::Base
  attr_accessible :apellido_materno, :apellido_paterno, :carrera, :fecha_inicio, :nombres, :rut, :sede
end
