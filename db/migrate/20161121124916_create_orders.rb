class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :total
      t.integer :user_id
      t.string :item
      t.string :billing_name
      t.string :billing_address
      t.timestamps
    end
  end
end
