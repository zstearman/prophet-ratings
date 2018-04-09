class GamesController < ApplicationController
  
  def show
    @game = Game.find(params[:id])
    @home_team_game = TeamGame.find_by(game: @game, home: true)
  end
end
