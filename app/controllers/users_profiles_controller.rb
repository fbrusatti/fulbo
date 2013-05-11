class UsersProfilesController < ApplicationController

  # the profile is available only if user is authenticates 
  before_filter :authenticate_user!

  # POST /users_profiles
  def create
  end

  # GET /users_profiles/new
  def new
  end
  
  # GET /users_profiles/:id/edit
  def edit
  end
  
  # GET /users_profiles/:id
  def show
  end
  
  # PUT /users_profiles/:id
  def update
  end
end
