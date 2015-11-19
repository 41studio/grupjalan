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
#
# Indexes
#
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_group_id        (group_id)
#  index_trips_on_member_size     (member_size)
#  index_trips_on_slug            (slug) UNIQUE
#  index_trips_on_user_id         (user_id)
#

require 'test_helper'

class TripTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
