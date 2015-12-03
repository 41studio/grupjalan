json.(@post, :id, :description, :group_id, :created_at)
json.votes @post.cached_votes_up

json.photo do
  json.original @post.photo_url
  json.thumb @post.photo_url(:thumb)
  json.small @post.photo_url(:small)
  json.medium @post.photo_url(:medium)
  json.cover @post.photo_url(:cover)
end