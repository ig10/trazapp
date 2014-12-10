class Configuracion < ActiveRecord::Base
  has_one :usuario, class_name: 'Usuario', foreign_key: :autor
  attr_accessible :nombre_archivo, :autor, :formato, :created_at, :updated_at, :status

  STATUS = {0 => 'complete', 1 => 'incomplete', 2 => 'unknown'}

  def self.cargar(archivo, autor, status = 0)
    nombre, formato = archivo.original_filename.split('.')
    create(
      nombre_archivo: nombre,
      formato: formato,
      autor: autor,
      status: status
      )
  end


end