# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  slug           :string
#  start_to_trip  :date
#  end_to_trip    :date
#  group_id       :integer
#  destination_id :integer
#
# Indexes
#
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_group_id        (group_id)
#  index_trips_on_slug            (slug) UNIQUE
#

class Trip < ActiveRecord::Base
  searchkick text_start: [:name_place], autocomplete: ['name_place']

  with_options dependent: :destroy do |assoc|
    has_many :posts
    has_many :groups
  end
  belongs_to :user
end
