require 'test_helper'

class LawyerAnsweredQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
