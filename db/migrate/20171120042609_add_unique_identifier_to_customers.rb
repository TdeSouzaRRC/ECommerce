class AddUniqueIdentifierToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :unique_identifier, :string
  end
end
