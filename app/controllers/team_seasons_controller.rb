class TeamSeasonsController < ApplicationController
  def index
    @team_seasons = TeamSeason.all
  end
end
