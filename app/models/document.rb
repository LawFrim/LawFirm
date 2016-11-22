class Document < ApplicationRecord
  belongs_to :user
  has_many :feedbacks
  mount_uploaders :client_docs, ClientdocsUploader
  # 文档对象链接
  has_many :notifications, as: :notifiable


  serialize :client_docs, JSON
end

# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  description :text
#  client_docs :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_name   :string
#
