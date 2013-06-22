class AffiliationsController < ApplicationController
  respond_to :js

  before_filter :authenticate_user!
  before_filter :verify_amount_of_teams, only: [:create]

  def create
    @league = League.find(params[:league_id])
    @team = Team.find(params[:affiliation][:team_id])
    @league.affiliate(@team)
    respond_with @league
  end

  def destroy
    @league = League.find(params[:league_id])
    @team = Affiliation.find(params[:id]).team
    @id = params[:id]
    @league.unaffiliated(@team)
    respond_with @league
  end

  private
    def verify_amount_of_teams
      @league = League.find(params[:league_id])
      if @league.teams.count >= @league.number_teams.to_i
        render js: "alert ('#{t('.leagues.edit.limit_of_teams')}')"
      end
    end
end
