class AddUseridToLegalmatter < ActiveRecord::Migration[5.0]
  def change
    add_column :legalmatters, :user_id, :integer
  end
end
