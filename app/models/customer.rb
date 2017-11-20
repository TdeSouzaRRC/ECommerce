class Customer < ApplicationRecord
    validates :full_name, :address, :city, :country, :postal_code, :email, :province_id, presence: true
    validates :email, uniqueness: true
    
    belongs_to :province
    has_many :orders
    has_one :user_login
end
