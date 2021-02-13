class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :details
      t.integer :salary
      t.string :level
      t.string :requirements
      t.string :deadline
      t.integer :quantity_of_positions
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
