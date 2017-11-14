class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.decimal :pst_rate
      t.decimal :gst_rate
      t.decimal :hst_rate

      t.timestamps
    end
  end
end
