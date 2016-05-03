module Pro
  module AbilityConcern extend ActiveSupport::Concern
    included do
      # overriding CanCan::ControllerAdditions
      def current_ability
        @current_ability = ProAbility.new(current_pro)
      end
    end
  end
end
