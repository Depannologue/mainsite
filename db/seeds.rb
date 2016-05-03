# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  email: "admin@depannologue.fr",
  password: "admin_depannologue_fr",
  role: "admin"
)
if !Rails.env.production?
  User.create(
    email: "pro+1@depannologue.fr",
    password: "pro_depannologue_fr",
    role: "contractor",
    firstname: 'Abc',
    lastname: 'Def',
    phone_number: '0606060606'
  )
  User.create(
    email: "user@depannologue.fr",
    password: "user_depannologue_fr",
    role: "customer",
    firstname: 'Abc',
    lastname: 'Def',
    phone_number: '0606060606'
  )
end
