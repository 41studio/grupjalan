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
#  index_groups_on_slug     (slug) UNIQUE
#  index_groups_on_user_id  (user_id)
#

<<<<<<< HEAD
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
=======
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
>>>>>>> 4d29a427b4f50836ca7ab627803659d2d6c5f9f5
#
# Indexes
#
#  index_groups_on_slug  (slug) UNIQUE
<<<<<<< HEAD
=======
#
# Indexes
#
#  index_groups_on_category_id  (category_id)
#  index_groups_on_trip_id      (trip_id)
#  index_groups_on_user_id      (user_id)
>>>>>>> 4d29a427b4f50836ca7ab627803659d2d6c5f9f5
#

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
