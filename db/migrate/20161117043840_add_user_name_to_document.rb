class AddUserNameToDocument < ActiveRecord::Migration[5.0]
  def change
   add_column :documents, :user_name, :string
  end
end
