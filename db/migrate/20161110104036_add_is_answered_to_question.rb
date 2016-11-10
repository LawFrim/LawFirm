class AddIsAnsweredToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions,:is_answered,:boolean,default:true

  end
end
