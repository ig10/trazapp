class AddSiglaFieldForSecciones < ActiveRecord::Migration
  def change
    add_column :secciones, :sigla, :string
  end
end
