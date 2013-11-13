# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131112225053) do

  create_table "actividades", :force => true do |t|
    t.integer  "proyecto_id"
    t.string   "modulo"
    t.string   "funcionalidad"
    t.integer  "complejidad"
    t.string   "estado"
    t.date     "revision"
    t.float    "progreso"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "proyectos", :force => true do |t|
    t.string   "nombre"
    t.string   "estado",       :default => "activo"
    t.date     "fecha_cierre"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "tareas", :force => true do |t|
    t.integer  "actividad_id"
    t.text     "descripcion"
    t.date     "revision"
    t.string   "estado"
    t.float    "evaluacion"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "tmp_actividades", :force => true do |t|
    t.integer  "proyecto_id"
    t.string   "modulo"
    t.string   "funcionalidad"
    t.integer  "complejidad"
    t.string   "estado"
    t.date     "revision"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "tmp_proyectos", :force => true do |t|
    t.string   "nombre"
    t.string   "estado"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.date     "expire_date"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "rut"
    t.string   "nombre_completo"
    t.string   "correo_electronico"
    t.integer  "proyecto_id"
    t.string   "perfil"
    t.string   "sede"
    t.string   "carrera"
    t.boolean  "activo"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
