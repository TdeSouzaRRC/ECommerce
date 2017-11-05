class Product < ApplicationRecord
    validates :name, :description, :stock_quantity, :price, presence: true
    belongs_to :category
end
