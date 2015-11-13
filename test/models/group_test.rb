# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  location   :string
#  lat        :float
#  lng        :float
#  photo      :string
#  image      :string
#  slug       :string
#
# Indexes
#
#  index_groups_on_slug  (slug) UNIQUE
#

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
