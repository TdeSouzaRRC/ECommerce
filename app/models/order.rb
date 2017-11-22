class Order < ApplicationRecord
  validates :pst_rate,
            :gst_rate,
            :hst_rate,
            :customer_id,
            :order_status_id,
            presence: true

  belongs_to :customer
  has_many :line_items
  belongs_to :order_status
end
