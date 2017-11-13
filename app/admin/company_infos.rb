ActiveAdmin.register CompanyInfo do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
    permit_params :name, :address, :phone_number, :fax_number, :description, :email, :company_logo

    form do |f|
        f.inputs 'Details' do
            f.input :name
            f.input :address
            f.input :phone_number
            f.input :fax_number
            f.input :email
            f.input :description
        end
        f.inputs 'Upload' do
            f.input :company_logo, required: true, as: :file
        end
        f.actions
    end
end
