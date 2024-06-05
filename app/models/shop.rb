class Shop < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products

  validates :shop_name, presence: true
end