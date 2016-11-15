# == Schema Information
#
# Table name: mailboxer_conversations
#
#  id          :integer          not null, primary key
#  subject     :string           default("")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#

require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
