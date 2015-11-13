# == Schema Information
#
# Table name: trips
#
#  id          :integer          not null, primary key
#  name_place  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  slug        :string
#  member_size :integer          default(0)
#
# Indexes
#
#  index_trips_on_member_size  (member_size)
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_group_id        (group_id)
#  index_trips_on_slug            (slug) UNIQUE
#

class Trip < ActiveRecord::Base
  paginates_per 10
  extend FriendlyId
  friendly_id :name_place, use: :slugged

  searchkick text_start: [:name_place], autocomplete: ['name_place']

  with_options dependent: :destroy do |assoc|
    assoc.has_many :posts
  end
  has_and_belongs_to_many :users
  belongs_to :user
  belongs_to :group
  belongs_to :destination
  
  validates :name_place, uniqueness: true 
  
  def calculate_member_size
    self.member_size = self.users.count
    self.save
  end

end
