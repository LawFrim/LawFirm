class RenameReplyforToReplyForAnswerToAnswer < ActiveRecord::Migration[5.0]
  def change
    rename_column :answers, :replyfor, :reply_for_answer
  end
end
