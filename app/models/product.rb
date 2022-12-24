class Product < ApplicationRecord
  mount_uploader :image, AvatarUploader

  belongs_to :product_category
  has_many :ratings

  validates :name, :price, :quantity, presence: true
end
