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

	# has_and_belongs_to_many :users
	has_many :trips
	has_many :posts, dependent: :destroy
	belongs_to :user
	
	validates :name, :user_id, :location, :lat, :lng, presence: true
end
