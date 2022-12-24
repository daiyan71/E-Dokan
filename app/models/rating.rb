class Rating < ApplicationRecord
  belongs_to :product
  belongs_to :user

  after_save :set_product_rating

  def set_product_rating
    count = product.ratings.count
    total = 0
    product.ratings.each do |rating|
      total += rating.rating
    end

    product.current_rating = total*1.0/count
    product.rating_count = count
    product.save
  end

end
