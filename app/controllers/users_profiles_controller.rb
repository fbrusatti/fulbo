class UsersProfilesController < ApplicationController
  # for respond_with 
  respond_to :html

  # the profile is available only if user is authenticates 
  before_filter :authenticate_user!, only: [:edit, :update, :create, :new] 
  before_filter :verify_profile, only: [:new]
 
   # GET /users/:user_id/profile
  def show
    @user = User.find(params[:user_id])
    @profile = @user.user_profile
    # if request.path != user_profile_path(@user)
    #   redirect_to @profile, status: :moved_permanently
    # end
  end 

  # GET /users/:user_id/profile/new
  def new
    @profile = UserProfile.new
  end

  # respond_with user_profile_path(@user)  
  # POST /users/:user_id/profile
  def create
    @user = User.find(params[:user_id])
    @profile = @user.build_user_profile(params[:user_profile])
    if @profile.save
      flash[:success] = "Successfully created profile."
    end
    respond_with @profile, :location => user_profile_path
  end

  # GET /users_profiles/:id/edit
  def edit
    @profile = UserProfile.find_by_user_id(params[:user_id])
  end
  
  # PUT /users/:user_id/profile
  def update
    @profile = UserProfile.find_by_user_id(params[:user_id])
    if @profile.update_attributes(params[:user_profile])
      flash[:notice] = "Successfully updated profile."
    end
    respond_with @profile, :location => user_profile_path
  end

  private
    def verify_profile
      if !current_user.user_profile.nil?
        redirect_to root_path, notice: "you have a profile"
      end 
    end
end
