class Product < ApplicationRecord
    validates :name, presence: true
    validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
    
    has_rich_text :description
    has_rich_text :specifications
    
    # File attachments
    has_one_attached :main_image
    has_many_attached :gallery_images
    
    # Stock notifications
    has_many :stock_notifications, dependent: :destroy
    
    # Custom validation for file attachments
    validate :validate_main_image
    validate :validate_gallery_images
    
    def in_stock?
      stock_quantity > 0
    end
    
    def out_of_stock?
      stock_quantity == 0
    end
    
    def notify_subscribers!
      return unless in_stock?
      
      stock_notifications.where(notified_at: nil).find_each do |notification|
        StockNotificationMailer.back_in_stock(notification).deliver_now
        notification.update!(notified_at: Time.current)
      end
    end
    
    private
    
    def validate_main_image
      return unless main_image.attached?
      
      unless main_image.content_type.in?(%w[image/jpeg image/jpg image/png image/gif image/webp])
        errors.add(:main_image, I18n.t('errors.invalid_format'))
      end
      
      if main_image.byte_size > 5.megabytes
        errors.add(:main_image, I18n.t('errors.too_large'))
      end
    end
    
    def validate_gallery_images
      return unless gallery_images.attached?
      
      gallery_images.each do |image|
        unless image.content_type.in?(%w[image/jpeg image/jpg image/png image/gif image/webp])
          errors.add(:gallery_images, I18n.t('errors.invalid_format'))
        end
        
        if image.byte_size > 5.megabytes
          errors.add(:gallery_images, I18n.t('errors.too_large'))
        end
      end
    end
end
