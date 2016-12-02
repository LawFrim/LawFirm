class User < ApplicationRecord

  # 首页选项字段
  enum role: {用户: 0, 律师: 1}

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
     self.role ||= :用户
    #  self.is_lawyer = false
  end

    #尝试注册传递律师，结果都是律师了
  # after_initialize :set_user, :if => :new_record?
  # def set_user
  #   if self.role ||=:律师
  #     self.is_lawyer = true
  #     self.is_admin = false
  #   else
  #     self.is_lawyer = false
  #     self.is_admin = false
  #   end
  #  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  mount_uploader :user_avatar, AvatarUploader
  mount_uploader :certificate, CertificateUploader




  # f120-mailbox
  acts_as_messageable

  has_many :questions
  has_many :answers
  has_many :documents
  has_many :feedbacks



  # 将用户与律师角色建立一对一关系
  has_one :lawyer
  # 将律师与问题建立多对多关系
  # 律师不得问问题！！！
  # has_many :answered_questions, :through => :lawyer_answereds, :source => :question

  # f783-提示
  has_many :notifications


  has_many :orders

  def admin?
    is_admin
  end



  # 重写的send_message(加入了question_id参数用于指定对应的question)

  def send_message(recipients, msg_body, subject, question, sanitize_text = true, attachment = nil, message_timestamp = Time.now)
    convo = Mailboxer::ConversationBuilder.new(subject: subject,
                                               created_at: message_timestamp,
                                               updated_at: message_timestamp).build

    message = Mailboxer::MessageBuilder.new(sender: self,
                                            conversation: convo,
                                            recipients: recipients,
                                            body: msg_body,
                                            subject: subject,
                                            attachment: attachment,
                                            created_at: message_timestamp,
                                            updated_at: message_timestamp).build

    convo.question_id = question.id
    convo.save

    message.deliver false, sanitize_text
  end





  def is_lawyer!
    lawyer = Lawyer.new
    lawyer.user_id = self.id
    lawyer.save
  end







  def lawyer?
  is_lawyer
  end

  def pay!
    self.update_columns(is_vip: true)
  end

  #scope :recent, -> { order("created_at DESC")}
  scope :area, -> { order("area DESC")}
  scope :district, -> { order("district DESC")}

  scope :lawyer, -> { where("is_lawyer" => true)}
  scope :account,-> { where("is_lawyer" => false)}



  include Gravtastic
  gravtastic


  # 自己答过的问题
  def answered_questions
    # 如果未答题，则返回空值，否则返回回答过的问题
    if self.lawyer.present?
      q = self.lawyer.lawyer_answered_questions
      questions = q.map {|x| x.question }
      return questions.uniq      
    else
      return []
    end
  end
  #


end
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE)
#  is_lawyer              :boolean          default(FALSE)
#  user_name              :string
#  user_avatar            :string
#  district               :string
#  area                   :string
#  lawfirm                :string
#  role                   :integer
#  is_vip                 :boolean          default(FALSE)
#  certificate            :string
#  certificate_number     :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
