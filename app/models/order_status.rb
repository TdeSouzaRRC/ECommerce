class OrderStatus < ApplicationRecord
    validates :status, required: true
    
    belongs_to :order
end
