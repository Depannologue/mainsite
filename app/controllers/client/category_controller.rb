#create : creer une addresse
#show: préremplir le formulaire si addresse existante
class Client::CategoryController < ApplicationController

  def create
    #Vérifier si le codepostal est deservi
    if ZipCode.managed? params[:zipcode]
        #verifier si address existe déjà, on crée une sinon
        if !session[:current_address_id].present?
          address = Address.new
        else
          id = session[:current_address_id]
          address = Address.getAdressById id
        end
        #On recupére les données du formulaire et on buils l'adresse
        #To-Do: validation via java script, et afficher les erreur activeRecord si .save fail
        if address.setAddress({address1: params[:address1], address2: params[:address2], zipcode: params[:zipcode], phone_number: params[:phone_number]})
          id = address.id
          session[:current_address_id] = id
          redirect_to "/client/devis/show/#{id}"
        else
          raise "ERROR"
        end
    else
      #To-Do afficher l'erreur aulieu d'un raise
      raise "Code postal non deservi"
    end
  end

  def show
    render 'category'
    session[:type_intervention_id] = params[:id]
    if session[:current_address_id].present?
      id = session[:current_address_id]
      address = Address.getAdressById(id)
      @address1 = address.address1
      @address2 = address.address2
      @zipcode = address.zipcode
      @city = address.city
      @phone_number = address.phone_number
    end
  end
end
