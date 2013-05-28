class SportCenterController < ApplicationController
  # for respond_with
  respond_to :html
  
  def index
    @sport_centers = SportCenter.all
  end
    
  def show
  	@user = User.find(params[:user_id])
	@sport_center = @user.sport_center

    # if request.path != user_profile_path(@user)
    #   redirect_to user_profile_path(@user), status: :moved_permanently
    # end
    
  end
end
