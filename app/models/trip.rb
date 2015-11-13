# == Schema Information
#
# Table name: trips
#
<<<<<<< HEAD
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
=======
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
>>>>>>> 4d29a427b4f50836ca7ab627803659d2d6c5f9f5
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
