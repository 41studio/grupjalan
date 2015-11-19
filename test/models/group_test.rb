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
#  index_groups_on_destination_id  (destination_id)
#  index_groups_on_slug            (slug) UNIQUE
#  index_groups_on_user_id         (user_id)
#

#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  location       :string
#  lat            :float
#  lng            :float
#  photo          :string
#  image          :string
#  destination_id :integer
#  slug           :string
#
# Indexes
#
#  index_groups_on_slug  (slug) UNIQUE

#
# Indexes
#
#  index_groups_on_category_id  (category_id)
#  index_groups_on_trip_id      (trip_id)
#  index_groups_on_user_id      (user_id)
#

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
