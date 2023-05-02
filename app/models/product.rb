class Product < ApplicationRecord
    validates :name, presence: true
    
    has_rich_text :description
    has_rich_text :specifications
    
    # File attachments
    has_one_attached :main_image
    has_many_attached :gallery_images
    
    # Custom validation for file attachments
    validate :validate_main_image
    validate :validate_gallery_images
    
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
