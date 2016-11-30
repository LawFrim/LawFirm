class Notification < ApplicationRecord

  # 用户可以直接调用
  belongs_to :recipient ,class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  # 读过的
  scope :unread, -> { where(read_at: nil) }
  # 最近5条
  #scope :recent, -> { order(created_at: :desc).limit(5) }

end

# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  question_id     :integer
#  document_id     :integer
#  active_type     :string
#  read_at         :datetime
#  action          :string
#  notifiable_id   :integer
#  notifiable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  recipient_id    :integer
#  actor_id        :integer
#
