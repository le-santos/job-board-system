class AddRoleToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :role, :integer, default: 0
  end
end
