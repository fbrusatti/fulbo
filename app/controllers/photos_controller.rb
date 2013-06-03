class PhotosController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!, only: [:new, :create, :destroy, :update]
  before_filter :verify_permission, only: [:new, :update, :destroy, :create]
  before_filter :limit_photos, only: [:new, :create]

  def index
    @team = Team.find(params[:team_id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @team = Team.find(params[:team_id])
    @photo = @team.photos.build(params[:photo ])
    if @photo.save
      redirect_to team_photos_path(@team), success: "Successfully created team."
    else
      render "new"
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully destroyed team."
    respond_with(@photo.team, @photo)
  end

  private

    def verify_permission
      @team = Team.find(params[:team_id])
      redirect_to team_photos_path(@team) unless current_user == @team.owner
    end

    def limit_photos
      @team = Team.find(params[:team_id])
      unless @team.photos.count < 9
        redirect_to team_photos_path(@team), notice: "you have arrived to limit of photos"
      end
    end
end
