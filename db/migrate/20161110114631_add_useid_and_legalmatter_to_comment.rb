class AddUseidAndLegalmatterToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :user_id, :integer
    add_column :comments, :legalmatter_id, :integer
  end
end
