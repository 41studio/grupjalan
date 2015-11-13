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
#  index_trips_on_user_id      (user_id)
#  index_trips_on_destination_id  (destination_id)
#  index_trips_on_group_id        (group_id)
#  index_trips_on_slug            (slug) UNIQUE
#

require 'test_helper'

class TripTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
