class AddLawyerFirmToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:lawfirm,:string
  end
end
