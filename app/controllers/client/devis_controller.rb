#show : afficher le devis
#create : créer l'intervention
class Client::DevisController < ApplicationController
  def show
    if params.has_key?(:id)
      id = params[:id]
      zipcode = ZipCode.getZipcode (Address.getAdressById id).zipcode
      @pros_now_available_and_nearby = Intervention.pros_now_available_and_nearby zipcode
      @intervention_type = InterventionType.getInterventionType session[:type_intervention_id]
      render 'devis'
    else
      redirect_to '/'
    end
  end

  def create
    #Récupérer le zipcode de l'adresse saisie afin de récupérer les pros availble
    zipcode = ZipCode.getZipcode (Address.getAdressById params[:id]).zipcode
    address = Address.getAdressById session[:current_address_id]
    pros = Intervention.pros_now_available_and_nearby zipcode
    #Mise à jour de l'adresse et Attribuer un diplucata de addresse au customer
    if address.setAddress({firstname: params[:firstname], lastname: params[:lastname]})
      customer_address = address.dup
    else
      #To-do Gérer l'erreur au cas le .save fail
      raise "ERROR"
    end
    # Vérifier si un customer existe sinon en créer un
    if !session[:customer_id]
      customer = User.new
      customer.setCustomer({address: customer_address, email: params[:email], firstname: address.firstname, lastname: address.lastname, phone_number: address.phone_number, role: "customer" })
      session[:customer_id] = customer.id
    else
      customer = User.getCustomer session[:customer_id]
    end
    #Création d'une intervention et attribution des différentes variantes
    intervention = Intervention.new
    intervention_type = InterventionType.getInterventionType session[:type_intervention_id]
    intervention.setIntervention({state: "pending_pro_validation", customer: customer, address: address, intervention_type: intervention_type })
    #supression de l'address de la session si elle existe
    session.delete(:current_address_id) if session[:current_address_id]
    #Envoie de mail et sms de confiramation de commande au client
    ClientMailer.confirm_booking(intervention).deliver_later
    NotifyBookingOkBySmsService.perform(intervention)
    #Envoie de mail à l'ensemble des pros disponibles
    pros.each do |pro|
      ProMailer.notify_intervention_created(pro, intervention).deliver_later
    end
    #Envoie sms aux pros
    NotifyProsBySmsService.perform(intervention, pros)
    #Redirection vers le recap de la commande
    redirect_to "/client/commande/show/#{intervention.id}"
  end
end
