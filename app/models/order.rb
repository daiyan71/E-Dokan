class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :name, :address, :contact_number, :payment_status, presence: true

  UNPAID = 0

  enum payment_status:{
      'Unpaid': 0,
      'Pending': 1,
      'Succeeded': 2,
      'Failed': 3,
  }

  after_create :save_order_number

  def save_order_number
    self.order_number = "OR-#{self.id}"
    self.save
  end

end
