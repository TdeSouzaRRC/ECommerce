class AddPaymentIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :payment_id, :string
  end
end
