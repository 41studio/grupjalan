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
#
# Indexes
#
#  index_groups_on_destination_id  (destination_id)
#  index_groups_on_slug            (slug) UNIQUE
#  index_groups_on_user_id         (user_id)
#

class Group < ActiveRecord::Base
	paginates_per 5
	extend FriendlyId
	friendly_id :name, use: :slugged

	# searchkick text_start: [:name_place],autocomplete: ['name_place']
	mount_uploader :photo, PhotoUploader
	mount_uploader :image, ImageUploader
  

	CATEGORIES = ['Pantai', 'Wisata', 'Laut', 'Taman']

	scope :by_trip, -> (trip) { where(trip: trip) }
	scope :joined, -> (user_id) { where(user_id: user_id) }
	scope :not_joined, -> (user_id) { where.not(user_id: user_id) }
	scope :by_name, -> (name) { where('LOWER(name) ILIKE ?', "%#{name.downcase}%") }
	scope :by_categories, -> (categories) { where("categories @> string_to_array(?, '')", categories) }

	belongs_to :user
  has_many :users, through: :trips, source: 'user'

	with_options dependent: :destroy do |assoc|
		assoc.has_many   :posts
		assoc.has_many   :messages
	end	

	has_many :trips, dependent: :destroy
	has_many :posts, dependent: :destroy
	belongs_to :destination
	
	validates :name, :user_id, :location, :lat, :lng, presence: true


	def self.order_by(column = 'created_at', type = 'desc')
		columns = ['created_at', 'name']

		if ['desc', 'asc'].include?(type) && columns.include?(column)
			order(column.to_sym => type.to_sym)
		else
			order(created_at: :desc)
		end
	end

	def self.explore(params)
		if params.nil?
			self.all
		else
			name = params[:name] if params[:name]
			categories = params[:categories] if params[:categories]
			sort = params[:sort] if params[:sort]

			by_name(name).by_categories(categories).order_explore(sort)
		end
	end

	def self.order_explore(type)
		sort =  case type
						when 'oldest'
							'created_at asc'
						when 'members'
							'members_count desc'
						else
							'created_at desc'
						end

		order(sort)
	end
end
