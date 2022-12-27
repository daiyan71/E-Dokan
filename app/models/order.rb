class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :name, :address, :contact_number, :payment_status, presence: true

  UNPAID = 0
  INCOMPLETE = 0
  COMPLETED = 1
  CANCELED = 2

  enum payment_status:{
      'Unpaid': 0,
      'Pending': 1,
      'Succeeded': 2,
      'Failed': 3,
  }
  enum order_status:{
      'Incomplete': 0,
      'Completed': 1,
      'Canceled': 2
  }

  def set_order_status(status)
    if status == COMPLETED
      self.order_status = COMPLETED
    elsif status == CANCELED
      if Succeeded?
        return false
      else
        self.order_status = CANCELED
      end
    end
    return self.save
  end

  after_create :save_order_number

  def save_order_number
    self.order_number = "OR-#{self.id}"
    self.save
  end

end
