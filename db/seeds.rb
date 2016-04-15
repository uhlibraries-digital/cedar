# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.where(email: 'admin@iqvoc').none?
  User.create! do |user|
    user.forename = 'Admin'
    user.surname  = 'Istrator'
    user.email    = 'admin@iqvoc'
    user.password = 'admin'
    user.password_confirmation = 'admin'
    user.active = true
    user.role = 'administrator'
  end
end

if User.where(email: 'demo@iqvoc').none?
  User.create! do |user|
    user.forename = 'Demo'
    user.surname  = 'User'
    user.email    = 'demo@iqvoc'
    user.password = 'cooluri'
    user.password_confirmation = 'cooluri'
    user.active = true
    user.role = 'reader'
  end
end