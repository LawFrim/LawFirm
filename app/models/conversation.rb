class Conversation < Mailboxer::Conversation

  # 建立一个新的conversation继承自mailboxer
  belongs_to :question

end

# == Schema Information
#
# Table name: mailboxer_conversations
#
#  id          :integer          not null, primary key
#  subject     :string           default("")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#
