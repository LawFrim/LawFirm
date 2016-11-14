class AddConversationIdToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :conversation_id, :integer
  end
end
