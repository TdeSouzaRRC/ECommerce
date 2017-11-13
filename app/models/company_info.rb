class CompanyInfo < ApplicationRecord
    has_attached_file :company_logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :company_logo, content_type: /\Aimage\/.*\z/
end
