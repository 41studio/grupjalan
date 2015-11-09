# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  group_name    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  trip_id       :integer
#  user_id       :integer
#  location      :string
#  lat           :float
#  lng           :float
#  photo         :string
#  image         :string
#  category_id   :integer
#  start_to_trip :date
#  end_to_trip   :date
#
# Indexes
#
#  index_groups_on_category_id  (category_id)
#  index_groups_on_trip_id      (trip_id)
#  index_groups_on_user_id      (user_id)
#

class Group < ActiveRecord::Base
	# searchkick text_start: [:name_place],autocomplete: ['name_place']
	mount_uploader :photo, PhotoUploader
	mount_uploader :image, ImageUploader

	CATEGORIES = Category.pluck(:plan_category, :id)

	scope :by_trip, -> (trip) { where(trip: trip) }
	scope :joined, -> (user_id) { where(user_id: user_id) }
	scope :not_joined, -> (user_id) { where.not(user_id: user_id) }

	has_and_belongs_to_many :users
	belongs_to :category
	belongs_to :trip
  
	with_options dependent: :destroy do |assoc|
		assoc.has_many   :posts
		assoc.has_many   :messages
	end	
	
	validates  :group_name, :start_to_trip, :end_to_trip, :trip_id, :user_id, presence: true
	validates  :location, :lat, :lng, presence: true
end
