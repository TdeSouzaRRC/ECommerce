class RemoveCustomerRefFromUserLogins < ActiveRecord::Migration[5.1]
  def change
    remove_reference :user_logins, :customer, foreign_key: true
  end
end
