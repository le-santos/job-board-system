class AddMessageToJobApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :job_applications, :message, :string
  end
end
