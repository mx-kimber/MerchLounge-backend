class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  
  has_many :shops, dependent: :destroy
  has_many :products, dependent: :destroy # Add dependent: :destroy
end
