class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :conversations, class_name: 'Conversation', foreign_key: 'question_id'
  has_many :notifications
  # 文档对象链接
  has_many :notifications, as: :notifiable

  # f1042-建立问题附件连接
  mount_uploader :attachment, Mailboxer::AttachmentUploader



  scope :recent, -> { order("created_at DESC")}
  scope :area, -> { order("area DESC")}
  scope :district, -> { order("district DESC")}

  # 变成被回答状态
  def answered!
    self.is_answered = true
    self.save
  end
  
  # 变成待回答状态
  def reopened!
    self.is_answered = false
    self.save   
  end


end

# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  content     :text
#  area        :string
#  district    :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  is_answered :boolean          default(FALSE)
#  attachment  :string
#
