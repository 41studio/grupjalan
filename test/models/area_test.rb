# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  name       :string
#  country_id :integer
#  code       :string
#
# Indexes
#
#  index_areas_on_code        (code) UNIQUE
#  index_areas_on_country_id  (country_id)
#

require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
