require 'task_helpers/application_helper'

namespace :combined_tasks do
  
  desc "Initiate New Season"
  
  task initiate_season: :environment do
    Rake::Task["seasons_tasks:get_seasons"].invoke
    Rake::Task["teams_tasks:get_teams"].invoke
    Rake::Task["conferences_tasks:get_conferences"].invoke
    Rake::Task["conferences_tasks:get_conference_keys"].invoke
    Rake::Task["players_tasks:get_players"].invoke
    Rake::Task["team_seasons_tasks:get_team_seasons"].invoke
    Rake::Task["games_tasks:get_games"].invoke
    Rake::Task["team_games_tasks:get_team_games"].invoke
    Rake::Task["team_seasons_tasks:allowed_seasons_calculations"].invoke
    Rake::Task["team_seasons_tasks:team_seasons_calculations"].invoke
    Rake::Task["prophet_ratings:generate_ratings"].invoke
  end

end
