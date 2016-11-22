class Order < ApplicationRecord
  belongs_to :user
  def set_payment_with!(method)
    self.update_columns(payment_method: method)
  end

  def pay!
    self.update_columns(is_paid: true)
  end
end

# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  total           :integer
#  user_id         :integer
#  item            :string
#  billing_name    :string
#  billing_address :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_paid         :boolean          default(FALSE)
#  payment_method  :string
#
