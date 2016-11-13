class AddReplyToUserToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :reply_to_user, :integer
  end
end
