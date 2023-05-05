# Preview all emails at http://localhost:3000/rails/mailers/stock_notification_mailer
class StockNotificationMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/stock_notification_mailer/back_in_stock
  def back_in_stock
    StockNotificationMailer.back_in_stock
  end
end
