class SportCenterLeaguesController < ApplicationController

  def index
    @sport_center = SportCenter.find(params[:sport_center_id])
    @leagues = @sport_center.leagues
  end

end