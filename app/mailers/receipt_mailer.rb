class ReceiptMailer < ApplicationMailer
  default from: 'mailfornascenia@gmail.com'

  def send_receipt(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Order Information')
  end
end
