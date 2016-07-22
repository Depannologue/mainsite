class AddInitialProfessions < ActiveRecord::Migration
  def change
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

    Profession.create(
      name: "Electricité",
      slug: "electricite"
    )

    Profession.create(
      name: "Chauffage",
      slug: "chauffage"
    )

    Profession.create(
      name: "Rénovation",
      slug: "renovation"
    )
  end
end
