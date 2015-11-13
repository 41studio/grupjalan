# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  name_place :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  slug       :string
#
# Indexes
#
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_group_id        (group_id)
#  index_trips_on_slug            (slug) UNIQUE
#

class Trip < ActiveRecord::Base
  # with_options dependent: :destroy do |assoc|
  #   assoc.has_many :posts
  # end
  # has_and_belongs_to_many :users
  belongs_to :user
  belongs_to :group
  belongs_to :destination
end
