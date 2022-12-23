class Cart < ApplicationRecord
  belongs_to :user , optional: true
  has_many :cart_items, dependent: :destroy

  def total_amount
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.quantity*cart_item.product.price
    end
    total
  end
end
