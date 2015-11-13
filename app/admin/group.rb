ActiveAdmin.register Group do

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

filter :group_name
filter :location
filter :created_at

index do 
  selectable_column
  id_column
  column :group_name
  column :location
  column :created_at
  actions
end

show :title => :group_name do 
  panel "Message History" do
    table_for(group.messages) do
      column("Id", :sortable => true) { |message| link_to "##{message.id}", admin_message_path(message)}
      column("Body") { |message| message.body}
      column("Created_at") { |message| pretty_format(message.created_at)}
    end 
  end 
end 

sidebar "Group Details", :only => :show do
  attributes_table_for group, :group_name, :location, :created_at
end 

end
