class AddStatusOnConfiguracionesLoad < ActiveRecord::Migration
  def change
    add_column :configuraciones, :status, :integer, default: 0
  end
end
