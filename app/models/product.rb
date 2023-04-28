class Product < ApplicationRecord
    validates :name, presence: true
    
    has_rich_text :description
    has_rich_text :specifications
end
