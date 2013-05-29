class SportCentersController < ApplicationController
  # for respond_with
  respond_to :html

  # GET /:user_id/sport_center
  def edit
    @user = User.find(params[:user_id])
    @sport_center = @user.sport_center
  end

  # PUT /:user_id/sport_center
  def update
    @user = User.find(params[:user_id])
    @sport_center = @user.sport_center

    if @sport_center.update_attributes(params[:user_sport_center])
      redirect_to user_sport_center_path(@user), :notice => "Successfully updated sport center."
    else
      render :edit
    end
  end
 
  def show
    @user = User.find(params[:user_id])
    @sport_center = @user.sport_center
  end
end
