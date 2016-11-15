class AddQuestionIdToMailboxerConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :mailboxer_conversations, :question_id, :integer
  end
end
