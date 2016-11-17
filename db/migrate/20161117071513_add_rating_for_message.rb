class AddRatingForMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :mailboxer_notifications,:rating,:integer
  end
end
