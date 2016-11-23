class CreateOrdersLists < ActiveRecord::Migration[5.0]
  def change
    create_table :orders_lists do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :user_name
      t.string :billing_name
      t.string :billing_address
      t.string :total
      t.string :item
      t.timestamps
    end
  end
end
