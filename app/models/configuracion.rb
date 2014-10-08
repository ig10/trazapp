class Configuracion < ActiveRecord::Base
  has_one :usuario, class_name: 'Usuario', foreign_key: :autor
  attr_accessible :nombre_archivo, :autor, :formato, :created_at, :updated_at


  def self.cargar(archivo)
    nombre, formato = archivo.original_filename.split('.')
    create(
      nombre_archivo: nombre,
      formato: formato,
      autor: 0
      )
  end


end