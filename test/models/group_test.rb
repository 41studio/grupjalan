# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  group_name    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  trip_id       :integer
#  user_id       :integer
#  location      :string
#  lat           :float
#  lng           :float
#  photo         :string
#  image         :string
#  category_id   :integer
#  start_to_trip :date
#  end_to_trip   :date
#

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
