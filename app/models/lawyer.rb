class Lawyer < ApplicationRecord
  belongs_to :user

  # 律师与问题的多对多关系
  has_many :lawyer_answered_questions
  # has_and_belongs_to_many :questions

end

# == Schema Information
#
# Table name: lawyers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
