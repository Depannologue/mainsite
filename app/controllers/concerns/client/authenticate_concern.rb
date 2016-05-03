module Client
  module AuthenticateConcern extend ActiveSupport::Concern
    included do
      before_filter :authenticate_client!, :is_client?

      private

      def is_client?
        if !current_client.has_role? :customer
          sign_out
          redirect_to client_root_path
        end
      end
    end
  end
end
