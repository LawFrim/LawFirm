class AddIsVipToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_vip, :boolean, default: false
  end
end
