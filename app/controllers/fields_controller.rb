class FieldsController < ApplicationController
  respond_to :html

  before_filter :verify_permission, only: [:edit,:new]

  def edit
    @field = Field.find(params[:id])
    @sport_center = @field.location.sport_center
  end

  def new
    @field = Field.new
    @location = Location.find(params[:location_id])
    @sport_center = @location.sport_center
  end

  def create
    @location = Location.find(params[:location_id])
    @field = @location.fields.build(params[:field])
    if @field.save
      flash[:success] = t('flash.field', message: t('flash.created'))
    end
    respond_with(@field.location, @field)
  end

  def show
    @field = Field.find(params[:id])
    @location = @field.location
    @sport_center = @location.sport_center
  end

  def update 
    @field = Field.find(params[:id])
    if @field.update_attributes(params[:field])
      flash[:success] = t('flash.field', message: t('flash.updated'))
    end
    respond_with(@field.location, @field, location: location_field_path)
  end

  def destroy
    @field = Field.find(params[:id])
    @field.destroy
    flash[:success] = t('flash.field', message: t('flash.destroyed'))
    respond_with(@field.location.sport_center, @field.location)
  end

  def index
    @sport_center =  current_user.sport_center
  end

  private

      def verify_permission
        @location = Location.find(params[:location_id])
        redirect_to(sport_center_path(current_user.sport_center), notice: t('.flash.permission_field')) unless current_user.sport_center == @location.sport_center
      end

end
