class AddDistrictAndAreaToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:district,:string
    add_column :users,:area,:string
  end
end
