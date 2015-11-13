# == Schema Information
#
# Table name: trips_users
#
#  id         :integer          not null, primary key
#  trip_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_trips_users_on_trip_id  (trip_id)
#  index_trips_users_on_user_id  (user_id)
#

class TripsUser < ActiveRecord::Base
end
