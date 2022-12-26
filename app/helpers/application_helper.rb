module ApplicationHelper
  def show_price(price)
    number_to_currency price*1.0/100
  end
end
