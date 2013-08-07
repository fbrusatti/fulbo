class CalendarsController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!
  before_filter :resource
  before_filter :verify_permission, only: [:show]

  def show
    respond_with @resource.reservations.to_json
  end

  private
  def resource
    hash_key = params.slice(:sport_center_id, :location_id, :field_id)
    klass = hash_key.keys.first.gsub('_id', '').classify.constantize

    @resource = klass.find(hash_key.values.first)
  end

  def verify_permission
    current_user == @resource.owner
  end
end
