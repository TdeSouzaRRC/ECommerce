class Product < ApplicationRecord
    has_attached_file :product_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\z/

    validates :name, :description, :stock_quantity, :price, presence: true
    belongs_to :category
end
