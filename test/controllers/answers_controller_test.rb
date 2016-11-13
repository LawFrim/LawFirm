# == Schema Information
#
# Table name: answers
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  conversation_id  :integer
#  question_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  reply_for_answer :integer
#  is_replied       :boolean          default(FALSE)
#  answer_type      :string           default("answer")
#  reply_to_user    :integer
#

require 'test_helper'

class AnswersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
