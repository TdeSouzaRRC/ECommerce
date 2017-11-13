class AddAttachmentCompanyLogoToCompanyInfos < ActiveRecord::Migration[5.1]
  def self.up
    change_table :company_infos do |t|
      t.attachment :company_logo
    end
  end

  def self.down
    remove_attachment :company_infos, :company_logo
  end
end
