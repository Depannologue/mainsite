class UserInformationsForm
  include ActiveModel::Model
  include Virtus

  attribute :firstname, String
  attribute :lastname, String
  attribute :zipcode, String
  attribute :address1, String
  attribute :address2, String
  attribute :zipcode, String
  attribute :city, String
  attribute :phone_number, String
  attribute :email, String
  attribute :intervention_date, String

  attr_reader :address, :customer

  ## Validation
  validates :phone_number,
            phony_plausible: true

  validates :zipcode,
            :city,
            :address1,
            :phone_number,
            :firstname,
            :lastname,
            :email,
            :intervention_date,
            presence: true

  validate :email_is_unique
  validate :zipcode_is_managed
  validate :intervention_date_is_valid

  ###
  def save
    if valid?
      persist
      true
    else
      false
    end
  end

 private

  def email_is_unique
    unless User.where(email: email).count == 0
     errors.add(:email, "l'email est déjà utilisé")
    end
  end

  def zipcode_is_managed
    unless ZipCode.managed? zipcode
     errors.add(:zipcode, 'code postal non désservi')
    end
  end

  def intervention_date_is_valid
    raise intervention_date.inspect
  end

  def persist
    address = Address.create(firstname: firstname,
                            lastname: lastname,
                            address1: address1,
                            address2: address2,
                            zipcode: zipcode,
                            city: city,
                            phone_number: phone_number)

    customer = User.create(firstname: firstname,
                            lastname: lastname,
                            phone_number: phone_number,
                            address: address,
                            email: email,
                            role: "customer")
    @address = address
    @customer = customer
  end
end
