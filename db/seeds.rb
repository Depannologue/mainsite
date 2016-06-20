# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  email: "admin@depannologue.fr",
  password: "password",
  role: "admin"
)

InterventionType.create(
  id: 1,
  kind: "closed_door",
  short_description: "Porte claquée non verrouillée",
  price: 200,
  created_at: "2016-01-14 15:31:51",
  updated_at: "2016-05-11 12:47:21",
  description: ""
)

InterventionType.create(
  id: 2,
  kind: "locked_door",
  short_description: "Porte fermée à clé",
  price: 100,
  created_at: "2016-01-14 15:32:18",
  updated_at: "2016-03-23 08:04:27",
  description: nil
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
