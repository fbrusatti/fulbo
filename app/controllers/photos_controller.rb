class PhotosController < ApplicationController
  respond_to :html, :js

  before_filter :authenticate_user!, only: [:new, :create, :destroy, :update]
  before_filter :verify_permission, only: [:new, :update, :destroy, :create]
  before_filter :limit_photos, only: [:create]

  def index
    @team = Team.find(params[:team_id])
  end

  def new
    @team = Team.find(params[:team_id])
    @photo = Photo.new
    respond_with(@team, @photo, location: team_photos_path)
  end

  def create
    @team = Team.find(params[:team_id])
    @photo = @team.photos.build(params[:photo])
    @photo.save
    respond_with(@team, @photo, location: team_photos_path)
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_with(@photo.team, @photo)
  end

  def edit
    @photo = Photo.find(params[:id])
    respond_with(@photo.team, @photo, location: team_photos_path)
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update_attributes(params[:photo])
    respond_with(@photo.team, @photo, location: team_photos_path)
  end

  private

    def verify_permission
      @team = Team.find(params[:team_id])
      redirect_to team_photos_path(@team) unless current_user == @team.owner
    end

    def limit_photos
      @team = Team.find(params[:team_id])
      unless @team.photos.count < PhotosHelper::PHOTO_LIMIT_AMOUNT
        redirect_to :back
      end
    end
end
