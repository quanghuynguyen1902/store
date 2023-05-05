class StockNotificationsController < ApplicationController
  allow_unauthenticated_access
  
  def create
    @product = Product.find(params[:product_id])
    @stock_notification = @product.stock_notifications.build(email: params[:email])
    
    if @stock_notification.save
      redirect_to @product, notice: t('stock_notifications.subscribed')
    else
      redirect_to @product, alert: t('stock_notifications.subscription_failed')
    end
  end

  def destroy
    @stock_notification = StockNotification.find(params[:id])
    @product = @stock_notification.product
    @stock_notification.destroy
    
    redirect_to @product, notice: t('stock_notifications.unsubscribed')
  end
end
