class Product < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :shops

  validates :product_name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end