module Client
  module AbilityConcern extend ActiveSupport::Concern
    included do
      # overriding CanCan::ControllerAdditions
      def current_ability
        @current_ability = ClientAbility.new(current_client)
      end
    end
  end
end
