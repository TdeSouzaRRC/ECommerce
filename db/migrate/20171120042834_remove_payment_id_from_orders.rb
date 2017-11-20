class RemovePaymentIdFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :payment_id, :string
  end
end
