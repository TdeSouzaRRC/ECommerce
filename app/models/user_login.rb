class UserLogin < ApplicationRecord
    validates :email, :password, presence: true

    belongs_to :customer
end
