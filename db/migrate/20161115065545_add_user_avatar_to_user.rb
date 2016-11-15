class AddUserAvatarToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_avatar, :string
  end
end
