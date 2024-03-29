# == Schema Information
#
# Table name: destinations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_destinations_on_name  (name) UNIQUE
#

class Destination < ActiveRecord::Base
  has_many :groups
end
