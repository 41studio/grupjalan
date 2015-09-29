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
#

class Group < ActiveRecord::Base
	# searchkick text_start: [:name_place],autocomplete: ['name_place']
	has_and_belongs_to_many :users
	belongs_to :user
	belongs_to :trip
	validates  :group_name, :start_to_trip, :end_to_trip, :trip_id, :user_id, presence: true
end
