class RenameUseridToRecipientidForNoti < ActiveRecord::Migration[5.0]
  def change
    rename_column :notifications, :user_id, :recipient_id
  end
end
