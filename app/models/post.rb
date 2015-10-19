# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  photo       :string
#  video       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  description :text
#  trip_id     :integer
#  group_id    :integer
#

class Post < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  mount_uploader :video, VideoUploader
  scope :by_group, -> (group_id){where(group_id: group_id)}
  belongs_to     :user
  belongs_to     :trip
  belongs_to     :group

  acts_as_commentable
  acts_as_votable
end
