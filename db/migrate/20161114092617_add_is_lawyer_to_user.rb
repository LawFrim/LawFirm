class AddIsLawyerToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:is_lawyer,:boolean,default:false
  end
end
