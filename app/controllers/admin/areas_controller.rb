class Admin::AreasController < ApplicationController
  include Admin::AuthenticateConcern
  include Admin::AbilityConcern
  layout 'admin/application'
  respond_to :html
  before_action :set_area, only: [:edit, :show, :update, :destroy]

  def index
    @q = Area.ransack params[:q]
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @areas = @q.result.page(params[:page]).per(params[:per_page])
  end 

  def edit
  end

  def show
  end

  # return the area attached to the zipcode
  def zipcode
    @area = ZipCode.find_by(zipcode: params[:zipcode])
    if @area
      render :json => @area.area.name.to_json
    else
      render :json => I18n.t("errors.activerecord.norecord").to_json
    end
  end

  def new
   @area = Area.new 
   respond_with @area
  end

  def create
    @area = Area.new area_params
    @area.save
    respond_with @area, :location => admin_areas_path
  end

  def update
    @area.update area_params
    respond_with @area, :location => admin_areas_path
  end

  def destroy
    @area.destroy
    respond_with @area, :location => admin_areas_path
  end

  private

  def area_params
    params.require(:area).permit(:name, zip_codes_attributes: [:id, :zipcode, :_destroy])
  end

  def set_area
    @area = Area.find(params[:id])
  end
end
