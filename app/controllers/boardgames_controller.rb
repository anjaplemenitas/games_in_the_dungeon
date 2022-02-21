class BoardgamesController < ApplicationController
  before_action :set_boardgame, only: [:show]

  def index
    @boardgames = Boardgame.all
  end

  def show
  end

  def new
    @boardgame = Boardgame.new
  end

  def create
    @user = User.find(params[:user_id])
    @boardgame = Boardgame.new(boardgames_params)
    @boardgame.user = @user
    if @boardgame.save
      redirect_to boardgame_path(@boardgame) notice: "You've successfully added your game"
    else
      render :new
    end
  end

  private

  def boardgames_params
    params.require(:boardgames).permit(:name, :genre, :description, :rating, :user_id)
  end

  def set_boardgame
    @boardgame = Boardgame.find(params[:id])
  end

end
