json.array! @groups do |group|
  json.id group.id
  json.group_name group.group_name
  json.location group.location
  json.start_to_trip group.start_to_trip
  json.end_to_trip group.end_to_trip
  json.photo group.photo
end