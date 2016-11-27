class LawyerAnsweredQuestion < ApplicationRecord

  belongs_to :lawyer
  belongs_to :question

end

# == Schema Information
#
# Table name: lawyer_answered_questions
#
#  id          :integer          not null, primary key
#  lawyer_id   :integer
#  question_id :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
