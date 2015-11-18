json.(@group, :id, :name, :lat, :lng, :location, :categories, :description, :created_at)

json.image do
  json.original @group.image_url
  json.small @group.image_url(:logo)
end

json.photo do
  json.original @group.photo_url
  json.small @group.photo_url(:small)
  json.medium @group.photo_url(:medium)
  json.cover @group.photo_url(:cover)
end

json.members @group.trips do |trip|
  json.user_id trip.user.id
  json.full_name trip.user.full_name
  json.start_to_trip trip.start_to_trip
  json.end_to_trip trip.end_to_trip
end

json.posts @group.posts do |post|
  json.post_id post.id

  json.description post.description
  json.comments_count post.comments_count
  json.votes_up post.cached_votes_up
  json.created_at post.created_at

  json.photo do
    json.original post.photo_url
    json.small post.photo_url(:small)
    json.medium post.photo_url(:medium)
    json.cover post.photo_url(:cover)
  end

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