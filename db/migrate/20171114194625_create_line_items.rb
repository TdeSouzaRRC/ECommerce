class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.Fixnum :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
