# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  is_answered :boolean          default(TRUE)
#  answer      :text
#

class Question < ApplicationRecord
  belongs_to :user

end
