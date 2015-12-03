json.array! @members do |trip|
  json.user_id trip.user.id
  json.full_name trip.user.full_name
  json.start_to_trip trip.start_to_trip.strftime("%d/%m/%Y")
  json.end_to_trip trip.end_to_trip.strftime("%d/%m/%Y")
end