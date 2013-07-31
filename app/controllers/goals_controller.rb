class GoalsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!

  def new
    @match = Match.find(params[:match_id])
    @goal  = @match.goals.new
  end

  def create
    @match = Match.find(params[:match_id])
    @goal = @match.goals.build(params[:goal])
    if @goal.save
      flash[:success] = t('flash.goal', message: t('flash.created'))
    else  
      flash[:success] = @goal.errors.full_messages.join(",")
    end
    respond_with @match, location: edit_match_path(@match)
  end

  def destroy
    @match = Match.find(params[:match_id])
    @goal = Goal.find(params[:id])
    @goal.destroy
    flash[:success] = t('flash.goal', message: t('flash.destroyed'))
    respond_with @match, location: edit_match_path(@match)
  end
      
end
