# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  location   :string
#  lat        :float
#  lng        :float
#  photo      :string
#  image      :string
#  slug       :string
#
# Indexes
#
#  index_groups_on_slug  (slug) UNIQUE
#

class Group < ActiveRecord::Base
	# searchkick text_start: [:name_place],autocomplete: ['name_place']
	mount_uploader :photo, PhotoUploader
	mount_uploader :image, ImageUploader

	scope :not_joined, -> (group_ids) { where('id NOT IN (?)',group_ids) }
	scope :by_trip, -> (trip) { where(trip: trip) }

	has_and_belongs_to_many :users
	belongs_to :category
	belongs_to :trip
	has_many   :posts, dependent: :destroy
	
	validates  :group_name, :start_to_trip, :end_to_trip, :trip_id, :user_id, presence: true
	validates  :location, :lat, :lng, presence: true
end
