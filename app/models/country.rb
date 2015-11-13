# == Schema Information
#
# Table name: countries
#
#  id   :integer          not null, primary key
#  name :string
#  code :string
#
# Indexes
#
#  index_countries_on_code  (code) UNIQUE
#

class Country < ActiveRecord::Base
  has_many :areas

  ALL = self.pluck(:name)
end
