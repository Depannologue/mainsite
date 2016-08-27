class AddInterventionType < ActiveRecord::Migration
  def change
    InterventionType.delete_all

    serrurerie = Profession.find_by_name "Serrurerie"

    InterventionType.create(price: 95, kind: 'a', short_description: 'Ouverture de porte claquée', description: 'Ouverture	de porte claquée', profession: serrurerie)
    InterventionType.create(price: 149, kind: 'a', short_description: 'Ouverture de porte vérrouillée', description: 'Ouverture	de porte vérrouillée', profession: serrurerie)
    InterventionType.create(price: 199, kind: 'a', short_description: 'Ouverture de porte blindé verrouillée', description: 'Ouverture	de porte blindé verrouillée', profession: serrurerie)
    InterventionType.create(price: 59, kind: 'a', short_description: 'Changement de cylindre', description: 'Changement de cylindre', profession: serrurerie)
    InterventionType.create(price: 88, kind: 'a', short_description: 'Cylindre clé plate', description: 'Cylindre clé plate', profession: serrurerie)
    InterventionType.create(price: 110, kind: 'a', short_description: 'Cylindre de sureté', description: 'Cylindre de sureté', profession: serrurerie)
    InterventionType.create(price: 330, kind: 'a', short_description: 'Cylindre de haute	sécurité', description: 'Cylindre de haute	sécurité', profession: serrurerie)
    InterventionType.create(price: 119, kind: 'a', short_description: 'Installation/changement	Verrou', description: 'Installation/changement	Verrou', profession: serrurerie)
    InterventionType.create(price: 197, kind: 'a', short_description: 'Installation/changement	Serrure	3	points', description: 'Installation/changement	Serrure	3	points', profession: serrurerie)
    InterventionType.create(price: 119, kind: 'a', short_description: 'Installation/Changement	Serrure	1	point', description: 'Installation/Changement	Serrure	1	point', profession: serrurerie)

    vitrerie  = Profession.find_by_name('Vitrerie')

    InterventionType.create(price: 219, kind: 'a', short_description: 'Changement simple vitrage 0m2 et 1m2', description: 'Changement simple vitrage 0m2 et 1m2', profession: vitrerie)
    InterventionType.create(price: 274, kind: 'a', short_description: 'Changement simple vitrage 1m2 à	1,5m2', description: 'Changement simple vitrage 1m2 à	1,5m2', profession: vitrerie)
    InterventionType.create(price: 329, kind: 'a', short_description: 'Changement simple vitrage de 1,5m2 à 2m2', description: 'Changement simple vitrage de 1,5m2 à 2m2', profession: vitrerie)
    InterventionType.create(price: 362, kind: 'a', short_description: 'Changement double vitrage 0m2	et 1m2', description: 'Changement double vitrage 0m2	et 1m2', profession: vitrerie)
    InterventionType.create(price: 395, kind: 'a', short_description: 'Changement double	vitrage	1m2	à	1,5m2', description: 'Changement doublevitrage	1m2	à	1,5m2', profession: vitrerie)
    InterventionType.create(price: 461, kind: 'a', short_description: 'Changement double	vitrage	de 1,5m2	à	2m2', description: 'Changement double	vitrage	de 1,5m2 à 2m2', profession: vitrerie)
    InterventionType.create(price: 149, kind: 'a', short_description: 'Mise en sécurité', description: 'Mise en sécurité', profession: vitrerie)


    plomberie = Profession.find_by_name('Plomberie')
    InterventionType.create(price: 119, kind: 'a', short_description: 'Recherche de fuite', description: 'Recherche de fuite', profession: plomberie)
    InterventionType.create(price: 149, kind: 'a', short_description: 'Débouchage', description: 'Débouchage', profession: plomberie)
    InterventionType.create(price: 149, kind: 'a', short_description: 'Réparation fuite	(WC/EVIER/LAVABO/BAIGNOIRE/DOUCHE)', description: 'Réparation fuite	(WC/EVIER/LAVABO/BAIGNOIRE/DOUCHE)', profession: plomberie)
    InterventionType.create(price: 279, kind: 'a', short_description: 'Réparation fuite	ballon	d\'eau chaude', description: 'Réparation fuite	ballon	d\'eau chaude', profession: plomberie)
    InterventionType.create(price: 149, kind: 'a', short_description: 'Remplacement Mecanisme chasse d\'eau wc simple', description: 'Remplacement Mecanisme chasse d\'eau wc simple', profession: plomberie)
    InterventionType.create(price: 199, kind: 'a', short_description: 'Remplacement mecanisme chasse d\'eau wc suspendu', description: 'Remplacement mecanisme chasse d\'eau wc suspendu', profession: plomberie)
    InterventionType.create(price: 99, kind: 'a', short_description: 'Remplacement robinet (Hors fourniture)', description: 'Remplacement robinet (Hors fourniture)', profession: plomberie)


    InterventionType.all.each do |intervention_type|
      intervention_type.slug = intervention_type.short_description.parameterize
      intervention_type.save
    end
  end
end
