class AddDeclineMessageToOffer < ActiveRecord::Migration[6.1]
  def change
    add_column :offers, :decline_message, :string
  end
end
