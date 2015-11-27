json.(@post, :id, :description, :comments_count, :created_at)
json.votes_up @post.cached_votes_up

if @post.photo.file.nil?
  json.photo nil
else
  json.photo do
    json.original @post.photo_url
    json.small @post.photo_url(:small)
    json.medium @post.photo_url(:medium)
    json.cover @post.photo_url(:cover)
  end
end

# user
json.user do |user|
  json.id @post.user.id
  json.full_name @post.user.full_name
end

json.comments @post.comments do |comment|
  json.(comment, :id, :comment, :created_at)
  
  # user
  json.user do |user|
    json.id comment.user_id
    json.full_name comment.user.full_name
  end
end