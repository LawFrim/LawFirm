class Document < ApplicationRecord
  belongs_to :user

  mount_uploaders :client_docs, ClientdocsUploader


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
#
