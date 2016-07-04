class ClientAbility
  include CanCan::Ability

  def initialize(client)
    client ||= User.new

    can :set_customer, Intervention do |intervention|
      intervention.customer.blank? ||
      (intervention.customer.present? && intervention.customer.encrypted_password.blank?) ||
      (intervention.customer_id == client.id)
    end

    can :read, Intervention do |intervention, interventions_client_token_ownership|

      !intervention.pending? && (
        (
          (
            intervention.customer.blank? ||
            (intervention.customer.present? && intervention.customer.encrypted_password.blank?)
          ) && interventions_client_token_ownership.present? && (interventions_client_token_ownership.include? intervention.client_token_ownership)
        ) ||
        (intervention.customer_id == client.id)
      )
    end
  end
end
