class AddServiceTypeToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :service_type, :string
  end
end
