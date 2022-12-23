class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, allow_destroy: true

  UNPAID = 1

  enum payment_status:{
      'Unpaid': 0,
      'Pending': 1,
      'Succeeded': 2,
      'Failed': 3,
  }

end
