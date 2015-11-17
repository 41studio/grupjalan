json.(@group, :id, :name, :lat, :lng, :location, :image, :photo, :categories, :description, :created_at)

json.members @group.trips do |trip|
  json.user_id trip.user.id
  json.full_name trip.user.full_name
  json.start_to_trip trip.start_to_trip
  json.end_to_trip trip.end_to_trip
end

json.posts @group.posts do |post|
  json.post_id post.id
  json.photo post.photo
  json.description post.description
  json.comments_count post.comments_count
  json.votes_up post.cached_votes_up
  json.votes_down post.cached_votes_down
  json.created_at post.created_at

  # user
  json.owner_id post.user.id
  json.owner post.user.full_name

  json.comments post.comments.page(params[:comment_page]) do |comment|
    json.comment_id comment.id
    json.comment comment.comment
    json.created_at comment.created_at

    # user
    json.commenter_id comment.user_id
    json.commenter_name comment.user.full_name
  end
end