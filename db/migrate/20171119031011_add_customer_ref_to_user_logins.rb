class AddCustomerRefToUserLogins < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_logins, :customer, foreign_key: true
  end
end
