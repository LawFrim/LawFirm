class RenameTypeFromQuestion < ActiveRecord::Migration[5.0]
  def change
    rename_column :questions, :type, :area
  end
end
