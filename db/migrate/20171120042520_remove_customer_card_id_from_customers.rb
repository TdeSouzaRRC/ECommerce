class RemoveCustomerCardIdFromCustomers < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :customer_card_id, :string
  end
end
