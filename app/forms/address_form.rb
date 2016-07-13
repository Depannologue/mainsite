class AddressForm
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

  attr_reader :id
  ## Validation
  validates :phone_number, phony_plausible: true
  validates :zipcode,
            :city,
            :address1,
            :phone_number,
            :firstname,
            :lastname,
            presence: true
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

 def persist
   address = Address.create(firstname: firstname,
                            lastname: lastname,
                            address1: address1,
                            address2: address2,
                            zipcode: zipcode,
                            city: city,
                            phone_number: phone_number)
  @id = address.id
 end


end
