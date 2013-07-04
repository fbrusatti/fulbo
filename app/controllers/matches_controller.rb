class MatchesController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!, only: [:new, :edit, :update]
  before_filter :verify_permission, only: [:edit]
  before_filter :verify_team, only: [:new]

  def index
    @matches = Match.all
  end

  def new
    @match= Match.new
    @team_local = current_user.team
  end

  def create
    @match = create_match(params[:macht])
    if @match.save
      flash[:success] = t('flash.team', message: t('flash.created'))
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
    flash[:notice] = t('flash.team', message: t('flash.destroyed'))
    respond_with(@match)
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:team])
      flash[:success] = t('flash.team', message: t('flash.updated'))
    end
    respond_with @match
  end

  private

    def verify_permission
    #   @match = Match.find(params[:id])
    #   redirect_to(teams_path, notice: t('flash.permission_team')) unless current_user == @team.owner
    end

    def verify_team
      # redirect_to(teams_path, notice: t('flash.verify_team')) unless current_user.team.blank?
    end
end