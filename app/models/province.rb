class Province < ApplicationRecord
  validates :name, :pst, :gst, :hst, presence: true
  validates :name, uniqueness: true

  has_many :customers
end
