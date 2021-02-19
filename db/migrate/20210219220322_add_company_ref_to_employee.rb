class AddCompanyRefToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_reference :employees, :company, foreign_key: true
  end
end
