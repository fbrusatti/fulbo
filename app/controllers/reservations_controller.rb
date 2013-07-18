class ReservationsController < ApplicationController
  respond_to :html

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = current_user.reservations.build( field_id: params[:field_id],
                                                    reservation_date: params[:reservation][:reservation_date] )

    if @reservation.save
      flash[:success] = t('flash.rent', message: t('flash.rented'))
    else
      flash[:error] = 'no se puede guardar'
    end

    respond_to do |format|
      format.html {
        if @reservation.errors.present?
          @field = @reservation.field
          @location = @reservation.field.location
          @sport_center = @reservation.field.location.sport_center

          render 'fields/show'
        else
          redirect_to sport_centers_path
        end

      }
    end
  end

  def index
    @reservations = Reservation.all
  end
end
