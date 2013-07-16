class ReservationsController < ApplicationController
  respond_to :html

  def new
    @reservation = Reservation.new
  end

  def create
    #debugger
    @reservation = current_user.reservations.create( :field_id  => params[:field_id],
                                                     :reservation_date => params[:reservation][:reservation_date] )
    if @reservation.save
      flash[:success] = t('flash.rent', message: t('flash.rented'))
    end
    respond_with(@reservation, :location => sport_centers_path)
  end

  def index
    @reservations = Reservation.all
  end

end