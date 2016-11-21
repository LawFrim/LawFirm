class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.item :string
      t.total :string
      t.billing_name :string
      t.billing_address :string
      t.timestamps
    end
  end
end
