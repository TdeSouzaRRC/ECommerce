class UserLogin < ApplicationRecord
    validates :email, :password, presence: true
    validates :email, uniqueness: true
    
    has_one :customer
end
