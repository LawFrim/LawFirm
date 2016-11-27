class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :conversations, class_name: 'Conversation', foreign_key: 'question_id'
  has_many :notifications
  # 文档对象链接
  has_many :notifications, as: :notifiable



  # 律师与问题的多对多关系
  has_many :lawyer_answered_questions
  # has_and_belongs_to_many :lawyers
 


  # f1042-建立问题附件连接
  mount_uploader :attachment, Mailboxer::AttachmentUploader

  # f1113-问题和文件审核必须有描述
  validates :content, presence: true



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


  def answered_lawyers
    q = self.lawyer_answered_questions
    users = q.map {|x| x.lawyer.user }
    return users
  end


end

# == Schema Information
#
# Table name: questions
#
#  id           :integer          not null, primary key
#  content      :text
#  area         :string
#  district     :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_answered  :boolean          default(FALSE)
#  attachment   :string
#  service_type :string
#
