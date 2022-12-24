# Preview all emails at http://localhost:3000/rails/mailers/receipt_mailer
class ReceiptMailerPreview < ActionMailer::Preview
  def send_receipt
    ReceiptMailer.send_receipt(User.first)
  end
end
