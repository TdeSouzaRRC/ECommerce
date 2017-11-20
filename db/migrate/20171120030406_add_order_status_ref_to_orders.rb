class AddOrderStatusRefToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :order_status, foreign_key: true
  end
end
