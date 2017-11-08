ActiveAdmin.register Product do
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
    permit_params :name, :description, :price, :stock_quantity, :category_id, :product_image
form do |f|
    f.inputs 'Details' do
        f.input :category
        f.input :name
        f.input :description
        f.input :price
        f.input :stock_quantity
    end
    f.inputs 'Upload' do
        f.input :product_image, required: true, as: :file
    end
    f.actions
end

end
