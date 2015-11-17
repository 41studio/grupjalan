json.array! @groups do |group|
  json.(group, :id, :name, :lat, :lng, :location, :image, :photo, :categories, :description, :created_at)
end