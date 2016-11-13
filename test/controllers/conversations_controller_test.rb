# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  question_id :integer
#  lawyer_id   :integer
#  client_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
