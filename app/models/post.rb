# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  title                   :string
#  photo                   :string
#  video                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :integer
#  description             :text
#  trip_id                 :integer
#  group_id                :integer
#  comments_count          :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  start_to_trip           :date
#  end_to_trip             :date
#
# Indexes
#
#  index_posts_on_cached_votes_down        (cached_votes_down)
#  index_posts_on_cached_votes_score       (cached_votes_score)
#  index_posts_on_cached_votes_total       (cached_votes_total)
#  index_posts_on_cached_votes_up          (cached_votes_up)
#  index_posts_on_cached_weighted_average  (cached_weighted_average)
#  index_posts_on_cached_weighted_score    (cached_weighted_score)
#  index_posts_on_cached_weighted_total    (cached_weighted_total)
#  index_posts_on_group_id                 (group_id)
#  index_posts_on_trip_id                  (trip_id)
#  index_posts_on_user_id                  (user_id)
#

class Post < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  # mount_uploader :video, VideoUploader

  before_save :date

  acts_as_commentable
  acts_as_votable
  
  belongs_to :user
  belongs_to :group

  validates :description, length: { maximum: 1000 }

  scope :by_group, -> (group_id) { where(group_id: group_id) }

  def date
    trip = self.user.trips.where(group: group.id).first
    self.start_to_trip = trip.start_to_trip
    self.end_to_trip = trip.end_to_trip
  end  
end
