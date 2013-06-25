class ProfilesController < ApplicationController
  respond_to :html

  before_filter :authenticate, only: [:edit, :update]
  before_filter :verify_profile, only: [:new]

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
    if request.path != user_profile_path(@user)
      redirect_to user_profile_path(@user), status: :moved_permanently
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
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

  private
    def verify_profile
      if !user_signed_in?
        redirect_to new_user_session_path, notice: "You need to sign in or sign up before continuing."
      end

      if user_signed_in? and current_user != User.find(params[:user_id])
        redirect_to root_path, notice: "you do not have a permission"
      end

      if user_signed_in? and current_user == User.find(params[:user_id]) and
           !current_user.profile.nil?
        redirect_to root_path, notice: "you have a profile"
      end
    end

    def authenticate
      if !user_signed_in?
        redirect_to new_user_session_path, notice: "You need to sign in or sign up before continuing."
      end

      if user_signed_in? and current_user != User.find(params[:user_id])
        redirect_to root_path, notice: "you do not have a permission"
      end
    end
end
