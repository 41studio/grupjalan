# == Schema Information
#
# Table name: groups
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
#  slug           :string
#  destination_id :integer
#  categories     :text             default([]), is an Array
#  description    :text
#  members_count  :integer
#  featured       :boolean          default(FALSE)
#
# Indexes
#
#  index_groups_on_destination_id  (destination_id)
#  index_groups_on_slug            (slug) UNIQUE
#  index_groups_on_user_id         (user_id)
#

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
