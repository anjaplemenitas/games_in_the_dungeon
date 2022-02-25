class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    @boardgame = Boardgame.find(params[:boardgame_id])

    set_params

    if @booking.save
      redirect_to user_path(current_user)
    else
      render 'boardgames/show'
    end
  end

  def destroy
    @booking = Booking.find(params[:boardgame_id])
    @booking.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_params
    @booking.rent = true
    @booking.user_id = @boardgame.user.id
    @booking.renter_id = current_user.id
    @booking.boardgame_id = @boardgame.id
  end

  def booking_params
    params.require(:booking).permit(:user_id, :buy, :rent, :rent_from, :rent_till)
  end
end
