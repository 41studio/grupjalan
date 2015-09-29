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
#

class Post < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  mount_uploader :video, VideoUploader
  belongs_to     :user
end
