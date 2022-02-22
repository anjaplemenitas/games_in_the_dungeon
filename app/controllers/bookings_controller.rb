class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new
    @boardgame = Boardgame.find(params[:boardgame_id])
    @booking.rent = true
    @booking.user_id = @boardgame.user.id
    @booking.renter_id = current_user.id
    @booking.boardgame_id = @boardgame.id

    if @booking.save
      redirect_to user_path(current_user)
    else
      render 'boardgames/show'
    end
  end

  # private

  # def booking_params
  #   params.require(:booking).permit(:user_id, :buy, :rent)
  # end
end
