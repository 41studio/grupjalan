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
#  destination_id :integer
#  slug           :string
#
# Indexes
#
#  index_groups_on_slug  (slug) UNIQUE
#
# Indexes
#
#  index_groups_on_category_id  (category_id)
#  index_groups_on_trip_id      (trip_id)
#  index_groups_on_user_id      (user_id)
#

class Group < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	# searchkick text_start: [:name_place],autocomplete: ['name_place']
	mount_uploader :photo, PhotoUploader
	mount_uploader :image, ImageUploader

	CATEGORIES = Category.pluck(:plan_category, :id)

	scope :by_trip, -> (trip) { where(trip: trip) }
	scope :joined, -> (user_id) { where(user_id: user_id) }
	scope :not_joined, -> (user_id) { where.not(user_id: user_id) }

	has_and_belongs_to_many :users
	belongs_to :category
	belongs_to :user
  
	with_options dependent: :destroy do |assoc|
		assoc.has_many   :posts
		assoc.has_many   :messages
	end	

	has_many :trips, dependent: :destroy
	has_many :posts, dependent: :destroy
	
	validates :name, :user_id, :location, :lat, :lng, presence: true
end
