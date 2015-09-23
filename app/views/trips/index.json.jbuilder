json.array!(@trips) do |trip|
  json.extract! trip, :id, :name_place
  json.url trip_url(trip, format: :json)
end
