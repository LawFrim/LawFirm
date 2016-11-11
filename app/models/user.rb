class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :all_exceptself, ->(user){where.not(id: user)}

  has_many :legalmatters
  has_many :comments

  def admin?
    is_admin
  end

  
end
