class AddCustomerCardIdToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :customer_card_id, :string
  end
end
