class UserProfileController < ApplicationController
  respond_to :html, :js

  before_filter :authenticate_user!, only: [:edit, :update]
  before_filter :verify_profile, only: [:new]

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def index
    @profiles = UserProfile.text_search(
                "#{params[:query_position]} #{params[:query]}")
                .page(params[:page])
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    if @profile.update_attributes(params[:user_profile])
      if params[:user_profile][:avatar].present? and (params[:user_profile][:remove_avatar] != "1")
        render :crop
      else
        redirect_to user_profile_path(@user), notice: "Successfully updated profile."
      end
    else
      render :edit
    end
  end
end
