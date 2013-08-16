class MatchesController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!, only: [:new, :edit, :update]
  before_filter :verify_permission_for_match, only: [:create, :edit]
  before_filter :verify_same_teams, only: [:create]

  def index
    @matches = Match.all
  end

  def new
    @match= Match.new
    @match.build_reservation
    @locations = Location.all
   end

  def create
    @match = Match.new(params[:match])
    if @match.save
      unless request.xhr?
        flash[:success] = t('flash.match', message: t('flash.created'))
      end
    end
    respond_with @match
  end

  def show
    @match = Match.find(params[:id])
    if request.path != match_path(@match)
      redirect_to match_path(@match), status: :moved_permanently
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    unless request.xhr?
      flash[:notice] = t('flash.match', message: t('flash.destroyed'))
    end
    respond_with @match do |format|
      format.js { render nothing: true }
    end
  end

  def edit
    @match = Match.find(params[:id])
    @locations = Location.all
    @local_players =  @match.local.players
  end

  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
      unless request.xhr?
        flash[:success] = t('flash.match', message: t('flash.updated'))
      end
    end
    respond_with @match

  end

  private

    def verify_permission_for_match
      #be required: be owner of any team (local or visitor) 
      #             or be owner of tourmentent
      #             or be owner of sportCenter   
    end

    def verify_same_teams
      @match = Match.new(params[:match])
      if @match.visitor == @match.local
        redirect_to(new_match_path, notice: t('flash.verify_same_teams')) 
      end  
    end
end