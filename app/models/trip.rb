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
#  member_size    :integer          default(0)
#  destination_id :integer
#  pribumi        :boolean          default(FALSE)
#
# Indexes
#
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_group_id        (group_id)
#  index_trips_on_member_size     (member_size)
#  index_trips_on_slug            (slug) UNIQUE
#  index_trips_on_user_id         (user_id)
#

class Trip < ActiveRecord::Base
  paginates_per 10

  with_options dependent: :destroy do |assoc|
    assoc.has_many :posts
  end

  has_and_belongs_to_many :users
  belongs_to :user
  belongs_to :group, counter_cache: :members_count
  belongs_to :destination

  before_save :check_is_pribumi
  
  def calculate_member_size
    self.member_size = self.users.count
    self.save
  end

  def check_is_pribumi
    if self.pribumi
      self.start_to_trip = nil
      self.end_to_trip = nil
    end
  end  

  validates :start_to_trip, :end_to_trip, presence: true, if: Proc.new { |trip| !trip.pribumi }
end
