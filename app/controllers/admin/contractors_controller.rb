class Admin::ContractorsController < ApplicationController
  include Admin::AuthenticateConcern
  include Admin::AbilityConcern
  layout 'admin/application'
  respond_to :html
  before_action :load_contractor, only: [:edit, :update, :destroy, :show]

  def index
    @contractors = User.contractors.page(params[:page])
  end

  def new
    @contractor = User.contractors.new
    @contractor.build_address
  end

  def create
    @contractor = User.contractors.new contractor_params
    @contractor.save
    respond_with @contractor, :location => admin_contractors_path
  end

  def show
  end

  def edit
    @contractor.build_address unless @contractor.address.present?
  end

  def update
    if params[:user].has_key?(:exceptional_availabilities_attributes) && params[:user][:exceptional_availabilities_attributes].has_key?('0')
      params[:user].delete(:exceptional_availabilities_attributes) if params[:user][:exceptional_availabilities_attributes]['0'][:available_now] == (@contractor.available_now? ? '1' : '0')
    end
    if contractor_params[:password].present?
      update_with_password
    else
      update_without_password
    end
  end

  def destroy
    @contractor.destroy
    flash[:success] = 'Professionnel supprimé'
    redirect_to admin_contractors_path
  end

  private

  def contractor_params
    params.require(:user).permit(
      :firstname,
      :lastname,
      :email,
      :phone_number,
      :password,
      :password_confirmation,
      exceptional_availabilities_attributes: [
        :available_now
      ],
      address_attributes: [
        :firstname,
        :lastname,
        :address1,
        :address2,
        :zipcode,
        :city,
        :id
      ],
      user_areas_attributes: [
        :id, 
        :user_id, 
        :area_id, 
        :_destroy
      ]
    )
  end

  def load_contractor
    @contractor = User.contractors.find(params[:id])
    @decorated_contractor = ProDecorator.new @contractor
  end

  def update_with_password
    begin
      if @contractor.update(contractor_params)
        flash[:success] = "Professionnel mise à jour"
        redirect_to admin_contractors_path
      else
        flash[:error] = "Erreur lors de la mise à jour du professionnel"
        render :edit
      end
    rescue ActiveRecord::RecordNotUnique => e
      flash[:error] = I18n.t('errors.activerecord.contractor.record_not_unique')
      render :edit      
    end
  end

  def update_without_password
    begin
      if @contractor.update_without_password(contractor_params)
        flash[:success] = "Professionnel mise à jour"
        redirect_to admin_contractors_path
      else
        flash[:error] = "Erreur lors de la mise à jour du professionnel"
        render :edit 
      end       
    rescue ActiveRecord::RecordNotUnique => e
      flash[:error] = I18n.t('errors.activerecord.contractor.record_not_unique')
      render :edit
    end
  end

  def areas
    @areas ||= Area.all.order(:name)
  end
  helper_method :areas  

end
