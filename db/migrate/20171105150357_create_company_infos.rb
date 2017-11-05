class CreateCompanyInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :company_infos do |t|
      t.string :name
      t.text :description
      t.string :phone_number
      t.string :fax_number
      t.text :address
      t.string :email

      t.timestamps
    end
  end
end
