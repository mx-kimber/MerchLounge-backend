class ProductImage < ApplicationRecord
  belongs_to :product

  attribute :public_id, :string
end
