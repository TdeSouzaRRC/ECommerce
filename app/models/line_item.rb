class LineItem < ApplicationRecord
    validates :quantity, :price, :order_id, :product_id, presence: true
    
    belongs_to :order
    has_one :product
end
