class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  UNPAID = 1

  enum payment_status:{
      'Unpaid': 0,
      'Pending': 1,
      'Succeeded': 2,
      'Failed': 3,
  }

end
