# == Schema Information
#
# Table name: cities
#
#  id      :integer          not null, primary key
#  name    :string
#  area_id :integer
#  code    :string
#
# Indexes
#
#  index_cities_on_area_id  (area_id)
#  index_cities_on_code     (code) UNIQUE
#

require 'test_helper'

class CityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
