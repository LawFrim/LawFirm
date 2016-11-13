class Answer < ApplicationRecord

  belongs_to :user
  belongs_to :question

  # 筛选出只和自己相关的答案
  scope :about_me, ->(user){where('reply_to_user=? OR user_id=?', user.id, user.id)}


end

# == Schema Information
#
# Table name: answers
#
#  id               :integer          not null, primary key
#  content          :text
#  question_id      :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  reply_for_answer :integer
#  is_replied       :boolean          default(FALSE)
#  answer_type      :string           default("answer")
#  reply_to_user    :integer
#
