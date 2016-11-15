class Conversation < Mailboxer::Conversation

  # 建立一个新的conversation继承自mailboxer
  belongs_to :question

end