class CompanyInfo < ApplicationRecord
  has_attached_file :company_logo,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'

  validates_attachment_content_type :company_logo, content_type: %r{\Aimage\/.*\z}

  validates :name,
            :description,
            :phone_number,
            :fax_number,
            :address,
            :email,
            :company_logo,
            presence: true
end
