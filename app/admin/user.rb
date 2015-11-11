ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  # index do
  #   column :photo
  #   actions
  # end

    index as: ActiveAdmin::Views::IndexAsTable do
      column :photo
      actions
   end

   
   # config.filters = false
   # config.per_page = 1
   filter :trips
   filter :gender, as: :check_boxes, collection: ['male', 'female']
   filter :first_name_or_last_name_cont, as: :string, label: "Name"
   

  index as: :grid, default: true do |user|
    link_to image_tag(user.photo), admin_user_path(user)
  end

end
