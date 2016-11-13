class AddReplayforToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :replyfor, :integer
  end
end
