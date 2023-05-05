class StockNotificationMailer < ApplicationMailer
  def back_in_stock(stock_notification)
    @stock_notification = stock_notification
    @product = stock_notification.product
    @email = stock_notification.email

    mail(
      to: @email,
      subject: t('stock_notification_mailer.back_in_stock.subject', product_name: @product.name)
    )
  end
end
