# == Schema Information
#
# Table name: countries
#
#  id   :integer          not null, primary key
#  name :string
#  code :string
#
# Indexes
#
#  index_countries_on_code  (code) UNIQUE
#

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
