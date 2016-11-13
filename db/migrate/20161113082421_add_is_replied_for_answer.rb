class AddIsRepliedForAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :is_replied, :boolean, default: false
  end
end
