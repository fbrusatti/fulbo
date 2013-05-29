class SportCentersController < ApplicationController
  # for respond_with
  respond_to :html

  def new
  end

  def create
  end
  
  def index
    @sport_centers = SportCenter.all
  end
    
  def show
    @user = User.find(params[:user_id])
    @sport_center = @user.sport_center
  end
end
