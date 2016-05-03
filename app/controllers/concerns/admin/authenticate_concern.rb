module Admin
  module AuthenticateConcern extend ActiveSupport::Concern
    included do
      before_filter :authenticate_admin!, :is_admin?

      private

      def is_admin?
        if !current_admin.has_role? :admin
          sign_out
          redirect_to admin_root_path
        end
      end
    end
  end
end
