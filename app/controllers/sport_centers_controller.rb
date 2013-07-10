  class SportCentersController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!, :verify_sport_center, except: :show

  def index
    @sport_center = SportCenter.all
  end

  def edit
    @sport_center = current_user.sport_center
  end

  def update
    @sport_center = current_user.sport_center
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
