class Estructura < ActiveRecord::Base
  has_many :proyectos, class_name: 'Proyecto', foreign_key: 'estructura_id'
  attr_accessible :nombre, :json


end