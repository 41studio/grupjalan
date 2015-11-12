ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :photo, :role, :status, :handphone, :gender, :birthday 
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
      column :role
      actions
   end

   form do |f|
     f.inputs do
       f.input :status, as: :text
       f.input :handphone
       f.input :gender, as: :radio, :collection => User::GENDERS
       f.input :role, :as => :string
       f.input :photo
       f.input :birthday 
      end
       f.actions
   end

   
   # config.filters = false
   # config.per_page = 1
   filter :photo
   filter :role
   filter :gender, as: :check_boxes, collection: ['male', 'female']
   filter :first_name_or_last_name_cont, as: :string, label: "Name"
   

  index as: :grid, default: false do |user|
    link_to image_tag(user.photo), admin_user_path(user)
  end

end
