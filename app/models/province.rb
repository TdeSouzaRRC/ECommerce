class Province < ApplicationRecord
    validates :name, :pst, :gst, :hst, presence: true
    
    has_many :customers
end
