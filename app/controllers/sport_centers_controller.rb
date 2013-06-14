  class SportCentersController < ApplicationController
  # for respond_with
  respond_to :html

  before_filter :verify_sport_center, :authenticate_user!

  def new
  end

  def create
  end

  # GET /:user_id/sport_center
  def edit
    @user = User.find(params[:user_id])
    @sport_center = @user.sport_center
  end

  # PUT /:user_id/sport_center
  def update
    @user = User.find(params[:user_id])
    @sport_center = @user.sport_center

    if @sport_center.update_attributes(params[:sport_center])
      redirect_to user_sport_center_path(@user), notice: t('flash.sport_center', message: t('flash.updated'))
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:user_id])
    @sport_center = @user.sport_center
  end

  private
    def verify_sport_center
      redirect_to root_path, notice: t('flash.have_sport_center') if current_user.sport_center.blank?
    end
end
