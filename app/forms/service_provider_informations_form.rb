class ServiceProviderInformationsForm
  include ActiveModel::Model
  include Virtus

  attribute :firstname, String
  attribute :lastname, String
  attribute :email, String
  attribute :phone_number, String
  attribute :is_a_plumber, Boolean
  attribute :is_a_locksmith, Boolean
  attribute :is_a_glazier, Boolean
  attribute :status, String
  attribute :file_kbis, Tempfile
  attribute :file_professional_insurance, Tempfile
  attribute :file_iban, Tempfile
  attribute :number_of_employees, Integer
  attribute :has_a_smartphone, Boolean


  ## Validation
  validates :phone_number,
            phony_plausible: true

  validates :firstname,
            :lastname,
            :email,
            :phone_number,
            :file_kbis,
            :file_professional_insurance,
            :file_iban,
            :status,
            :number_of_employees,
            :has_a_smartphone,
            presence: true

  validate :number_of_employees_is_positive
  validate :must_have_at_least_one_profession

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
    unless is_a_plumber || is_a_locksmith || is_a_glazier
      errors.add(:is_a_plumber, "Vous devez selectionner au moins une profession")
    end
  end

  def persist

  end
end
