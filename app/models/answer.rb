class Answer < ApplicationRecord

  mount_uploader :attachment, Mailboxer::AttachmentUploader

  belongs_to :user
  belongs_to :question



end

# == Schema Information
#
# Table name: answers
#
#  id              :integer          not null, primary key
#  content         :text
#  question_id     :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :integer
#  attachment      :string
#
