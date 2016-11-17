class AddUserNameToFeedback < ActiveRecord::Migration[5.0]
  def change
   add_column :feedbacks, :user_name, :string
  end
end
