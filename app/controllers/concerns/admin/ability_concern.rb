module Admin
  module AbilityConcern extend ActiveSupport::Concern
    included do
      # overriding CanCan::ControllerAdditions
      def current_ability
        @current_ability = AdminAbility.new(current_admin)
      end
    end
  end
end
