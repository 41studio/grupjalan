# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  group_name    :string
#  start_to_trip :string
#  end_to_trip   :string
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
#

class Group < ActiveRecord::Base
	# searchkick text_start: [:name_place],autocomplete: ['name_place']
	mount_uploader :photo, PhotoUploader
	mount_uploader :image, ImageUploader

	scope :by_trip, -> (trip) { where(trip: trip) }
	scope :joined, -> (user_id) { where(user_id: user_id) }
	scope :not_joined, -> (user_id) { where.not(user_id: user_id) }

	has_and_belongs_to_many :users
	belongs_to :category
	belongs_to :trip
	has_many   :posts, dependent: :destroy
	
	validates  :group_name, :start_to_trip, :end_to_trip, :trip_id, :user_id, presence: true
	validates  :location, :lat, :lng, presence: true
end
