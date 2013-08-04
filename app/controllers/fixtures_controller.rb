class FixturesController < ApplicationController
  respond_to :js, :html
  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :check_permission, only: [:new, :create]

  def new
    @days = params[:days]
    respond_to do |format|
      format.html do
        if request.xhr?
          render partial: 'fixtures/time_and_place', days: @days
        end
      end
    end
  end

  def create
    @rules = params[:rules].map { |rule|
      # wday - week day.
      # gt - game times.
      # ps - playing surfaces.
      RRSchedule::Rule.new(wday: rule[:day].to_i,
                           gt: dispatch_time(time_from: rule[:time_from],
                                             time_to: rule[:time_to]),
                           ps: rule[:fields])
    }
    @league.generate_fixture(rules: @rules)
    flash[:success] = t('flash.fixture',
                         message: t('flash.created'),
                         name: @league.name)
    respond_with @league
  end

  private
    def check_permission
      @league = League.find(params[:league_id])
      owner = @league.organizer.owner
      redirect_to league_path(@league) and return unless owner == current_user
      redirect_to league_path(@league) and return if @league.fixture
    end

    def dispatch_time(params={})
      t_from = params[:time_from]
      t_to = params[:time_to]
      t_game = params[:time_game] || 1.hour
      t_h = t_from.scan(/\d{2}/).first
      t_m = t_from.scan(/\d{2}/).last
      t_from = Time.new(2013,1,01, t_h,t_m,0, "+00:00")
      t_h = t_to.scan(/\d{2}/).first
      t_m = t_to.scan(/\d{2}/).last
      t_to = Time.new(2013,1,01, t_h,t_m,0, "+00:00")
      game_times = []
      t_iterator = t_from
      while t_iterator < t_to
        game_times << t_iterator.strftime( "%k:%M %p")
        t_iterator += t_game
      end
      game_times
    end
end
