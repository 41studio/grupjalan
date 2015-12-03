json.array! @groups do |group|
  json.(group, :id, :name, :lat, :lng, :location, :categories, :description, :created_at)

  json.image do
    json.original group.image_url
    json.small group.image_url(:logo)
  end

  json.photo do
    json.original group.photo_url
    json.small group.photo_url(:small)
    json.medium group.photo_url(:medium)
    json.cover group.photo_url(:cover)
  end
end