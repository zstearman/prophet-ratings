require 'task_helpers/application_helper'

namespace :combined_tasks do
  
  desc "Initiate New Season"
  task initiate_season: :environment do
    Rake::Task["seasons_tasks:get_seasons"].invoke
    Rake::Task["teams_tasks:get_teams"].invoke
    Rake::Task["conferences_tasks:get_conferences"].invoke
  end

end
