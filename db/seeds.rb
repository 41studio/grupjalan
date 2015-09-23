# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all

user = User.create :username => 'Agung', :first_name => 'agung', :last_name => '41studio', :email => 'agung@41studio.com', :role => 'admin', :password => 'top secret', :password_confirmation => 'top secret' 
user.trips.create([
  {
    name_place: 'pangandaran'
  },

  {
    name_place: 'Kawah Putih'
  },

  {
    name_place: 'Ciwidey'
  },

  {
   name_place: 'Candi Borobudur'
  },

  {
   name_place: 'Bali'
  },

  {
   name_place: 'Raja Ampat'
  },

  {
   name_place: 'Pantai Derawan' 
  },

  {
    name_place: 'Situ Patenggang'
  },

  {
    name_place: 'Bromo'
  },

  {
    name_place: 'Tangkuban Perahu'
  }
])

