class FixturesController < ApplicationController
  respond_to :js, :html
  before_filter :authenticate_user!, only: [:new, :create, :edit]
  before_filter :check_new_permission, only: [:new, :create]
  before_filter :check_exist_fixture, only: [:show, :edit]
  before_filter :check_edit_permission, only: [:edit]

  def show
    @weeks = @league.fixture.weeks.order(:number).page(params[:page]).per(1)
    @week = @weeks.first
  end

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
    redirect_to league_fixture_path(@league)
  end

  def edit
    @weeks = @league.fixture.weeks.order(:number).page(params[:page]).per(1)
    @week = @weeks.first
    @fields = @league.organizer.fields
    @match = Match.new(week_id: @week.id)
  end

  private
    def check_exist_fixture
      @league = League.find(params[:league_id])
      redirect_to league_path(@league) if @league.fixture.blank?
    end

    def check_new_permission
      @league = League.find(params[:league_id])
      owner = @league.organizer.owner
      redirect_to league_path(@league) and return unless owner == current_user
      redirect_to league_path(@league) and return if @league.fixture
    end

    def check_edit_permission
      owner = @league.organizer.owner
      redirect_to league_path(@league) unless owner == current_user
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
