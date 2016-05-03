class Pro::ProfileController < ProfileController
  include Pro::AuthenticateConcern
  include Pro::AbilityConcern
  layout 'pro/application'

  def edit
    @user.build_weekly_availability if @user.weekly_availability.blank?
  end

  def update
    respond_to do |format|
      format.html do
        if @user.update_attributes permitted_params
          flash.now[:success] = 'Votre profile a été mis à jour.'
        else
          flash.now[:error] = 'Impossible de mettre à jour votre profile.'
        end
        render :edit
      end
      format.json do
        @user.update_attributes permitted_params
        if params.key?(:user) && (
          params[:user].key?(:firstname) ||
          params[:user].key?(:lastname) ||
          params[:user].key?(:phone_number))
          respond_with_bip @user
        else
          render json: @user.to_json(include: [:address])
        end
      end
    end
  end

  def load_user
    @user = current_pro
  end

  private

  def permitted_params
    params.require(:user).permit(
      :firstname,
      :lastname,
      :phone_number,
      address_attributes: [
        :latitude,
        :longitude
      ],
      exceptional_availabilities_attributes: [
        :available_now
      ],
      weekly_availability_attributes: WeeklyAvailability::TIME_SLOTS.map do |from_to|
        WeeklyAvailability::DAYS.map do |day|
          :"#{day}_#{from_to}_availability"
        end
      end.flatten << :id
    )
  end
end
