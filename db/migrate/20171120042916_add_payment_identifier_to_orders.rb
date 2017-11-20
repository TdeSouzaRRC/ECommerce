class AddPaymentIdentifierToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :payment_identifier, :string
  end
end
