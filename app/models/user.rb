class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # f120-mailbox
  acts_as_messageable

  has_many :questions
  has_many :answers
  has_many :documents

  def admin?
    is_admin
  end


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
#  name                   :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
