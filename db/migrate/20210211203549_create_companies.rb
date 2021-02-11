class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description
      t.string :logo
      t.string :address
      t.string :tech_stack
      t.string :domain

      t.timestamps
    end
  end
end
