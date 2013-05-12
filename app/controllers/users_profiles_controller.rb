class UsersProfilesController < ApplicationController
  # for respond_with 
  # respond_to :html

  # the profile is available only if user is authenticates 
  before_filter :authenticate_user!#, :only[:new, :show, :edit]

 
   # GET /users_profiles/:id
  def show
    @profile = UserProfile.find(params[:id])
  end

  # GET /users_profiles/new
  def new
    @profile = UserProfile.new
  end
  

  # POST /users_profiles
  def create
    @profile = current_user.build_user_profile(params[:user_profile])
    if @profile.save
      redirect_to users_profile_path(@profile), success: "Successfully created profile."
    else
      render "new"
    end
  end

  # GET /users_profiles/:id/edit
  def edit
  end
  
  # PUT /users_profiles/:id
  def update
  end
end
