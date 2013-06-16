class LocationsController < ApplicationController
  respond_to :html

  before_filter :verify_permission, only: [:edit,:new]

  def new
    @location = Location.new
    @sport_center = current_user.sport_center
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      flash[:success] = t('flash.location', message: t('flash.updated'))
    end
    respond_with(current_user.sport_center, @location, location: sport_center_location_path)
  end

  def create
    @sport_center = current_user.sport_center
    @location = @sport_center.locations.create(params[:location])
    if @location.save
      flash[:success] = t('flash.location', message: t('flash.created'))
    end
    respond_with(current_user.sport_center, @location)
  end

  def show
    @location = Location.find(params[:id])
    @sport_center = current_user.sport_center
  end

  def index
    @sport_center = current_user.sport_center
    @locations = @sport_center.locations.all
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    flash[:success] = t('flash.location', message: t('flash.destroyed'))
    respond_with(current_user,location: sport_center_locations_path)
  end

  private

    def verify_permission
      @sport_center = SportCenter.find(params[:sport_center_id])
      redirect_to(sport_center_path(current_user.sport_center), notice: t('.flash.permission_location')) unless current_user.sport_center == @sport_center
    end
end
