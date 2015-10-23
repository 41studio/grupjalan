# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  name_place :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Trip < ActiveRecord::Base
  searchkick text_start: [:name_place], autocomplete: ['name_place']

  with_options dependent: :destroy do |assoc|
    has_many :posts
    has_many :groups
  end
  belongs_to :user
end
