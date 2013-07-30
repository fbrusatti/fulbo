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
                           gt: [rule[:time_from], rule[:time_to]],
                           ps: rule[:fields])
    }
    @league.generate_fixture(@rules)
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
end
