class StockNotification < ApplicationRecord
  belongs_to :product
  
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: { scope: :product_id }
  
  scope :pending, -> { where(notified_at: nil) }
  scope :notified, -> { where.not(notified_at: nil) }
end
