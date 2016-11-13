class Question < ApplicationRecord

  belongs_to :user
  has_many :answers
  has_many :conversations

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
