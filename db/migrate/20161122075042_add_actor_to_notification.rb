class AddActorToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :actor_id, :integer
  end
end
