  class SportCentersController < ApplicationController
  respond_to :html

  before_filter :verify_sport_center, :authenticate_user!

  def edit
    @sport_center = SportCenter.find(params[:id])
  end

  def update
    @sport_center = SportCenter.find(params[:id])
    if @sport_center.update_attributes(params[:sport_center])
      flash[:notice] = t('flash.sport_center', message: t('flash.updated'))
    end
    respond_with @sport_center
  end

  def show
    @sport_center = SportCenter.find(params[:id])
  end

  private
    def verify_sport_center
      redirect_to root_path, notice: t('flash.have_sport_center') if current_user.sport_center.blank?
    end
end
