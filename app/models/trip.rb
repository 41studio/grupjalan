# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  name_place :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  slug       :string
#
# Indexes
#
#  index_trips_on_slug     (slug) UNIQUE
#  index_trips_on_user_id  (user_id)
#

class Trip < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name_place, use: :slugged

  searchkick text_start: [:name_place], autocomplete: ['name_place']

  has_and_belongs_to_many :users
  
  with_options dependent: :destroy do |assoc|
    assoc.has_many :posts
    assoc.has_many :groups
  end
  belongs_to :user
end
