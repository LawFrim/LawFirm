require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: questions
#
#  id           :integer          not null, primary key
#  content      :text
#  area         :string
#  district     :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_answered  :boolean          default(FALSE)
#  attachment   :string
#  service_type :string
#
