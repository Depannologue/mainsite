class AddInitialProfessions < ActiveRecord::Migration
  def change
    Profession.create(
      name: "Serrurerie",
      slug: "#{name.parameterize}"
    )

    Profession.create(
      name: "Vitrerie",
      slug: "#{name.parameterize}"
    )

    Profession.create(
      name: "Plomberie",
      slug: "#{name.parameterize}"
    )

    Profession.create(
      name: "Electricité",
      slug: "#{name.parameterize}"
    )

    Profession.create(
      name: "Chauffage",
      slug: "#{name.parameterize}"
    )

    Profession.create(
      name: "Rénovation",
      slug: "#{name.parameterize}"
    )
  end
end
