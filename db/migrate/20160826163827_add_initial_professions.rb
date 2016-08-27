class AddInitialProfessions < ActiveRecord::Migration
  def change
    Profession.delete_all

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
  end
end
