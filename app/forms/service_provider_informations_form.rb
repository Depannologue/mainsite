class ServiceProviderInformationsForm
  include ActiveModel::Model
  include Virtus

  attribute :firstname, String
  attribute :lastname, String
  attribute :email, String
  attribute :phone_number, String
  attribute :society, String
  attribute :siret, String
  attribute :siege_address, String

  attribute :is_a_plumber, Boolean
  attribute :is_a_locksmith, Boolean
  attribute :is_a_glazier, Boolean
  attribute :is_a_heating_engineer, Boolean
  attribute :is_an_electrician, Boolean
  attribute :is_a_drywall_worker, Boolean
  attribute :is_a_painter, Boolean
  attribute :is_a_ground_setter, Boolean
  attribute :profession, Boolean

  attribute :status, String
  attribute :file_kbis, Tempfile
  attribute :file_professional_insurance, Tempfile
  attribute :file_iban, Tempfile
  attribute :number_of_employees, Integer
  attribute :has_a_smartphone, Boolean

  attribute :have_read_partnership_general_conditions, Boolean
  attribute :accepted_partnership_general_conditions, Boolean


  ## Validation

  validates :firstname,
            :lastname,
            :email,
            :phone_number,
            :status,
            :number_of_employees,
            presence: true

  validates :has_a_smartphone, inclusion: { in: [ true, false ] }

  validate :number_of_employees_is_positive
  validate :must_have_at_least_one_profession
  validate :must_accept_and_read_partnership_general_conditions

  ###
  def save
    if valid?
      true
    else
      false
    end
  end

 private

  def number_of_employees_is_positive
    if number_of_employees.to_i < 0
     errors.add(:number_of_employees, "Le nombre d'employés ne peut pas etre négatif")
    end
  end

  def must_have_at_least_one_profession
    unless is_a_plumber || is_a_locksmith || is_a_glazier || is_a_heating_engineer || is_an_electrician || is_a_drywall_worker || is_a_painter || is_a_ground_setter
      errors.add(:profession, "Vous devez selectionner au moins une profession")
    end
  end

  def must_accept_and_read_partnership_general_conditions
    unless have_read_partnership_general_conditions && accepted_partnership_general_conditions
      errors.add(:have_read_partnership_general_conditions, "Vous devez lire et accepter les conditions conditions générales de partenariat")
    end
  end

end
