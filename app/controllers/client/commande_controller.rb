# show: afficher les élements lié à une intervention 
class Client::CommandeController < ApplicationController
  def show
    intervention = Intervention.getIntervention params[:id]
    if intervention.customer.id.to_s == session[:customer_id].to_s
      @price = intervention.intervention_type.price
      @address = intervention.address.address1 + "   " + intervention.address.address2 + "   " + intervention.address.zipcode
      @pro_state = ''
      render 'commande'
    else
    end
  end
end
