class AddUserIdToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions,:user_id,:integer
  end
end
