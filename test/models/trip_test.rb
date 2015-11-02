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
#  index_trips_on_slug  (slug) UNIQUE
#

require 'test_helper'

class TripTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
