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
#  destination   :string
#

class Group < ActiveRecord::Base
	# searchkick text_start: [:name_place],autocomplete: ['name_place']
	belongs_to :trip
	has_many :users
end
