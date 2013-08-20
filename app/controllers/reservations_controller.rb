class ReservationsController < ApplicationController
  respond_to :html

  def new
    @reservation = Reservation.new
  end

  def create
    new_reservation = DateTime.parse(params[:reservation][:reservation_date])
    @reservation = current_user.reservations.build( field_id: params[:field_id],
                                                    reservation_date: new_reservation )
    
    reservation_on_field = Reservation.where( :field_id => params[:field_id] )
    if reservation_on_field.where("reservation_date BETWEEN ? AND ?", new_reservation - 1.hours, new_reservation + 1.hours ).blank?
      if @reservation.save 
        flash[:success] = t('flash.rent', message: t('flash.rented'))
      else 
        flash[:error] = t('flash.rent_error')
      end
    else
      flash[:error] = t('flash.field_ocupped')
    end    

    respond_to do |format|
      format.html {
        if @reservation.errors.present?
          @field = @reservation.field
          @location = @field.location
          @sport_center = @location.sport_center
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
