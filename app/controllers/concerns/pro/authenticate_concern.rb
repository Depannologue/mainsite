module Pro
  module AuthenticateConcern extend ActiveSupport::Concern
    included do
      before_filter :authenticate_pro!, :is_pro?

      private

      def is_pro?
        if !current_pro.has_role? :contractor
          sign_out
          redirect_to pro_root_path
        end
      end
    end
  end
end
