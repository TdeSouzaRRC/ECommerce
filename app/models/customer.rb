class Customer < ApplicationRecord
    validates :full_name, :address, :city, :country, :postal_code, :email, :province_id, presence: true
    
    belongs_to :province
    has_many :orders
end
