# == Schema Information
#
# Table name: groups
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  location       :string
#  lat            :float
#  lng            :float
#  photo          :string
#  image          :string
#  slug           :string
#  destination_id :integer
#  categories     :text             default([]), is an Array
#  description    :text
#  members_count  :integer
#  featured       :boolean          default(FALSE)
#
# Indexes
#
#  index_groups_on_destination_id  (destination_id)
#  index_groups_on_slug            (slug) UNIQUE
#  index_groups_on_user_id         (user_id)
#

module GroupsHelper
  def set_class_post(index = 0)
    if (index % 2).eql? 0
      'no-padding-right'
    else
      'no-padding-left'
    end
  end

  def value_name(params)
    if !params.nil? && params[:name]
      params[:name]
    end
  end

  def checked_categories(params)
    if !params.nil? && params[:categories]
      params[:categories]
    end
  end

  def selected_sort(params)
    if !params.nil? && params[:sort]
      params[:sort]
    else
      'newest'
    end
  end
end
