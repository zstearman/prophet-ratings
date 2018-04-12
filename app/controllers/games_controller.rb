class GamesController < ApplicationController
  
  def show
    @game = Game.find(params[:id])
    @away_team = @game.away_team
    @home_team = @game.home_team
    @home_team_game = TeamGame.find_by(game: @game, home: true)
    @away_team_game = TeamGame.find_by(game: @game, home: false)
    @away_team_season = @away_team_game.team_season
    @home_team_season = @home_team_game.team_season
    @away_player_games = @away_team_game.player_games.order("minutes desc")
    @home_player_games = @home_team_game.player_games.order("minutes desc")
  end
end
