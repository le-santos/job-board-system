class AddPersonalDataToCandidates < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates, :name, :string
    add_column :candidates, :cpf, :string
    add_column :candidates, :phone, :string
    add_column :candidates, :biography, :string
    add_column :candidates, :skills, :string
  end
end
