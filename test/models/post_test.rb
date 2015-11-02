# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  title                   :string
#  photo                   :string
#  video                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :integer
#  description             :text
#  trip_id                 :integer
#  group_id                :integer
#  comments_count          :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#
# Indexes
#
#  index_posts_on_cached_votes_down        (cached_votes_down)
#  index_posts_on_cached_votes_score       (cached_votes_score)
#  index_posts_on_cached_votes_total       (cached_votes_total)
#  index_posts_on_cached_votes_up          (cached_votes_up)
#  index_posts_on_cached_weighted_average  (cached_weighted_average)
#  index_posts_on_cached_weighted_score    (cached_weighted_score)
#  index_posts_on_cached_weighted_total    (cached_weighted_total)
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
