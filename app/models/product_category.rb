class ProductCategory < ApplicationRecord
  validates :category_name, presence: true
end
