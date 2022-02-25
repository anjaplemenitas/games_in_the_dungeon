class BoardgamesController < ApplicationController
  before_action :set_boardgame, only: %i[show destroy]

  def index
    if params[:query].present?
      @boardgames = Boardgame.search_by_name_and_genre(params[:query])
    else
      @boardgames = Boardgame.all.sort_by(&:created_at).reverse
    end
  end

  def show
    @booking = Booking.new
  end

  def new
    @user = current_user
    @boardgame = Boardgame.new
    @genre = []
    @genre = Boardgame.all.map(&:genre).join(", ").split(", ").sort.uniq
  end

  def create
    @user = current_user
    @boardgame = Boardgame.new(boardgames_params)
    @boardgame.user = @user
    if @boardgame.save
      redirect_to boardgame_path(@boardgame), notice: "You've successfully added your game"
    else
      @genre = []
      @genre = Boardgame.all.map(&:genre).join(", ").split(", ").sort.uniq
      render :new
    end
  end

  def destroy
    @boardgame.destroy
    redirect_to user_path(current_user)
  end

  private

  def boardgames_params
    params.require(:boardgame).permit(:name,
                                      :genre,
                                      :description,
                                      :user_id,
                                      :photo,
                                      :rating,
                                      :min_players,
                                      :max_players,
                                      :min_playtime,
                                      :max_playtime,
                                      :age_rating)
  end

  def set_boardgame
    @boardgame = Boardgame.find(params[:id])
  end

end
