class UsersProfilesController < ApplicationController
  # for respond_with 
  respond_to :html

  # the profile is available only if user is authenticates 
  before_filter :authenticate_user!
  before_filter :verify_profile, only: [:new]
 
   # GET /users/:user_id/profile
  def show
    @profile = current_user.user_profile
  end 

  # GET /users/:user_id/profile/new
  def new
    @profile = UserProfile.new
  end
  
  # POST /users/:user_id/profile
  def create
    @profile = current_user.build_user_profile(params[:user_profile])
    if @profile.save
      flash[:success] = "Successfully created profile."
    end
    respond_with @profile
  end

  # GET /users_profiles/:id/edit
  def edit
    @profile = current_user.user_profile
  end
  
  # PUT /users/:user_id/profile
  def update
    @profile = current_user.user_profile
    if @profile.update_attributes(params[:user_profile])
      flash[:notice] = "Successfully updated product."
    end
    respond_with @profile 
  end

  private
    def verify_profile
      if !current_user.user_profile.nil?
        redirect_to root_path, notice: "you have a profile"
      end 
    end
end
