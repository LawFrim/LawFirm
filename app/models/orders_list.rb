class OrdersList < ApplicationRecord
  belongs_to :order
  belongs_to :user

end

# == Schema Information
#
# Table name: orders_lists
#
#  id              :integer          not null, primary key
#  order_id        :integer
#  user_id         :integer
#  user_name       :string
#  billing_name    :string
#  billing_address :string
#  total           :string
#  item            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
