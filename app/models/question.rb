class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_one :conversation, class_name: 'Conversation', foreign_key: 'question_id'

  scope :recent, -> { order('created_at DESC') }
  scope :area, -> { order('area DESC') }
  scope :district, -> { order('district DESC') }
end

# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  area       :string
#  district   :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
