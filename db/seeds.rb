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
  short_description: "Porte claquée",
  price: 200,
  created_at: "2016-01-14 15:31:51",
  updated_at: "2016-05-11 12:47:21",
  description: "",
  profession_id: 1,
  parent_id:nil,
  slug:"porte-claquee"
)

InterventionType.create(
  id: 2,
  kind: "locked_door",
  short_description: "Porte fermée à clé",
  price: 100,
  created_at: "2016-01-14 15:32:18",
  updated_at: "2016-03-23 08:04:27",
  description: nil,
  profession_id: 1,
  parent_id:nil,
  slug:"porte-fermee-a-cle"
)

InterventionType.create(
  id: 3,
  kind: "locked_door",
  short_description: "Porte blindée fermée à clé",
  price: 100,
  created_at: "2016-01-14 15:32:18",
  updated_at: "2016-03-23 08:04:27",
  description: nil,
  profession_id: 1,
  parent_id:2,
  slug:"porte-blindee"
)

InterventionType.create(
  id: 4,
  kind: "locked_door",
  short_description: "Porte fermée à clé",
  price: 100,
  created_at: "2016-01-14 15:32:18",
  updated_at: "2016-03-23 08:04:27",
  description: nil,
  profession_id: 1,
  parent_id:2,
  slug:"porte"
)

InterventionType.create(
  id: 5,
  kind: "locked_door",
  short_description: "Porte",
  price: 100,
  created_at: "2016-01-14 15:32:18",
  updated_at: "2016-03-23 08:04:27",
  description: nil,
  profession_id: 1,
  parent_id:1,
  slug:"porte"
)

InterventionType.create(
  id: 6,
  kind: "locked_door",
  short_description: "vitre cassée",
  price: 100,
  created_at: "2016-01-14 15:32:18",
  updated_at: "2016-03-23 08:04:27",
  description: nil,
  profession_id: 2,
  parent_id: nil,
  slug:"vitre-cassee"
)
InterventionType.create(
  id: 7,
  kind: "locked_door",
  short_description: "double vitrage",
  price: 100,
  created_at: "2016-01-14 15:32:18",
  updated_at: "2016-03-23 08:04:27",
  description: nil,
  parent_id: 6,
  profession_id: 2,
  slug:"double-vitrage"
)

InterventionType.create(
  id: 8,
  kind: "locked_door",
  short_description: "débouchage",
  price: 100,
  created_at: "2016-01-14 15:32:18",
  updated_at: "2016-03-23 08:04:27",
  description: nil,
  profession_id: 3,
  parent_id: nil,
  slug: "debouchage"
)
InterventionType.create(
  id: 9,
  kind: "locked_door",
  short_description: "evier bouché",
  price: 100,
  created_at: "2016-01-14 15:32:18",
  updated_at: "2016-03-23 08:04:27",
  description: nil,
  profession_id: 3,
  parent_id: 8,
  slug: "evier"
)

Profession.create(

  name: "Serrurerie",
  slug: "serrurerie"
)

Profession.create(

  name: "Vitrerie",
  slug: "vitrerie"
)

Profession.create(

  name: "Plomberie",
  slug: "plomberie"
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
