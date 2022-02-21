class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @user = User.find(params[:user_id])
    @booking.user = @user
    @boardgame = Boardgame.new(params[:boardgame_id])

    if @user.save
      redirect_to boardgame_booking_path(@booking)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :booking_id, :buy, :rent)
  end
end
