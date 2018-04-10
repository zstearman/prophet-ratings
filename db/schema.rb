# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180410152306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowed_seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_season_id"
    t.string "school"
    t.integer "games"
    t.integer "minutes"
    t.integer "field_goals_made"
    t.integer "field_goals_attempted"
    t.decimal "field_goals_percentage"
    t.decimal "effective_field_goal_percentage"
    t.integer "two_pointers_made"
    t.integer "two_pointers_attempted"
    t.decimal "two_pointers_percentage"
    t.integer "three_pointers_made"
    t.integer "three_pointers_attempted"
    t.decimal "three_pointers_percentage"
    t.integer "free_throws_made"
    t.integer "free_throws_attempted"
    t.decimal "free_throws_percentage"
    t.integer "offensive_rebounds"
    t.integer "defensive_rebounds"
    t.integer "rebounds"
    t.decimal "offensive_rebounds_percentage"
    t.decimal "defensive_rebounds_percentage"
    t.decimal "total_rebounds_percentage"
    t.integer "assists"
    t.integer "steals"
    t.integer "blocked_shots"
    t.integer "turnovers"
    t.integer "personal_fouls"
    t.integer "points"
    t.decimal "true_shooting_attempts"
    t.decimal "true_shooting_percentage"
    t.decimal "steals_percentage"
    t.decimal "blocks_percentage"
    t.decimal "turnovers_percentage"
    t.decimal "assists_percentage"
    t.decimal "three_pointers_per_field_goal_attempted"
    t.decimal "free_throws_per_field_goal_attempted"
    t.integer "possessions"
    t.index ["school"], name: "index_allowed_seasons_on_school"
    t.index ["team_season_id"], name: "index_allowed_seasons_on_team_season_id"
  end

  create_table "conferences", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "global_conference_id"
    t.index ["global_conference_id"], name: "index_conferences_on_global_conference_id"
    t.index ["name"], name: "index_conferences_on_name"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "season_id"
    t.integer "season_type"
    t.string "status"
    t.integer "away_score"
    t.integer "home_score"
    t.datetime "updated"
    t.string "period"
    t.decimal "point_spread"
    t.decimal "over_under"
    t.integer "away_money_line"
    t.integer "home_money_line"
    t.integer "tournament_id"
    t.string "bracket"
    t.integer "round"
    t.integer "away_seed"
    t.integer "home_seed"
    t.integer "global_game_id"
    t.integer "away_previous_global_game_id"
    t.integer "home_previous_global_game_id"
    t.integer "tournament_display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "home_team_season_id"
    t.integer "away_team_season_id"
    t.date "date"
    t.datetime "date_time"
    t.string "home_team_key"
    t.string "away_team_key"
    t.integer "possessions"
    t.integer "global_away_team_id"
    t.integer "global_home_team_id"
    t.string "location_type"
    t.string "location"
    t.index ["date"], name: "index_games_on_date"
    t.index ["global_game_id"], name: "index_games_on_global_game_id"
    t.index ["season_id"], name: "index_games_on_season_id"
  end

  create_table "player_games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "global_player_id"
    t.integer "global_player_game_id"
    t.string "name"
    t.integer "stat_id"
    t.bigint "team_id"
    t.integer "season_type"
    t.bigint "team_season_id"
    t.string "position"
    t.string "injury_status"
    t.string "injury_body_part"
    t.date "injury_start_date"
    t.string "injury_notes"
    t.integer "global_team_id"
    t.integer "global_game_id"
    t.integer "global_opponent_id"
    t.bigint "game_id"
    t.bigint "team_game_id"
    t.integer "minutes"
    t.integer "field_goals_made"
    t.integer "field_goals_attempted"
    t.bigint "player_id"
    t.string "home_or_away"
    t.decimal "field_goals_percentage"
    t.decimal "effective_field_goals_percentage"
    t.integer "two_pointers_made"
    t.integer "two_pointers_attempted"
    t.decimal "two_pointers_percentage"
    t.integer "three_pointers_made"
    t.integer "three_pointers_attempted"
    t.decimal "three_pointers_percentage"
    t.index ["game_id"], name: "index_player_games_on_game_id"
    t.index ["global_player_game_id"], name: "index_player_games_on_global_player_game_id"
    t.index ["global_player_id"], name: "index_player_games_on_global_player_id"
    t.index ["player_id"], name: "index_player_games_on_player_id"
    t.index ["team_game_id"], name: "index_player_games_on_team_game_id"
    t.index ["team_id"], name: "index_player_games_on_team_id"
    t.index ["team_season_id"], name: "index_player_games_on_team_season_id"
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "global_player_id"
    t.string "first_name"
    t.string "last_name"
    t.bigint "team_id"
    t.integer "jersey"
    t.string "position"
    t.string "year"
    t.integer "height"
    t.integer "weight"
    t.string "birth_city"
    t.string "birth_state"
    t.string "high_school"
    t.index ["global_player_id"], name: "index_players_on_global_player_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "prophet_ratings", force: :cascade do |t|
    t.bigint "team_season_id"
    t.decimal "p_ortg"
    t.decimal "p_drtg"
    t.decimal "p_tempo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "p_rtg"
    t.index ["team_season_id"], name: "index_prophet_ratings_on_team_season_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "start_year"
    t.integer "end_year"
    t.string "description"
    t.date "regular_season_start_date"
    t.date "post_season_start_date"
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season"
    t.index ["end_year"], name: "index_seasons_on_end_year"
  end

  create_table "team_games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_season_id"
    t.bigint "team_id"
    t.bigint "game_id"
    t.integer "wins"
    t.integer "losses"
    t.integer "conference_wins"
    t.integer "conference_losses"
    t.decimal "possessions"
    t.integer "opponent_id"
    t.string "opponent_key"
    t.date "day"
    t.datetime "date_time"
    t.boolean "home"
    t.datetime "updated"
    t.integer "season_type"
    t.integer "field_goals_made"
    t.integer "field_goals_attempted"
    t.decimal "field_goals_percentage"
    t.decimal "effective_field_goal_percentage"
    t.integer "two_pointers_made"
    t.integer "two_pointers_attempted"
    t.decimal "two_pointers_percentage"
    t.integer "three_pointers_made"
    t.integer "three_pointers_attempted"
    t.decimal "three_pointers_percentage"
    t.integer "free_throws_made"
    t.integer "free_throws_attempted"
    t.decimal "free_throws_percentage"
    t.integer "offensive_rebounds"
    t.integer "defensive_rebounds"
    t.integer "rebounds"
    t.integer "assists"
    t.integer "steals"
    t.integer "blocked_shots"
    t.integer "turnovers"
    t.integer "personal_fouls"
    t.integer "points"
    t.decimal "true_shooting_attempts"
    t.decimal "true_shooting_percentage"
    t.integer "season"
    t.integer "global_game_id"
    t.integer "opponent_game_id"
    t.index ["game_id"], name: "index_team_games_on_game_id"
    t.index ["team_id"], name: "index_team_games_on_team_id"
    t.index ["team_season_id"], name: "index_team_games_on_team_season_id"
  end

  create_table "team_seasons", force: :cascade do |t|
    t.decimal "p_rtg"
    t.decimal "p_ortg"
    t.decimal "p_drtg"
    t.decimal "p_tempo"
    t.integer "wins"
    t.integer "losses"
    t.integer "conference_wins"
    t.datetime "updated"
    t.integer "games"
    t.integer "minutes"
    t.integer "field_goals_made"
    t.integer "field_goals_attempted"
    t.decimal "field_goals_percentage"
    t.decimal "effective_field_goal_percentage"
    t.integer "two_pointers_made"
    t.integer "two_pointers_attempted"
    t.decimal "two_pointers_percentage"
    t.integer "three_pointers_made"
    t.integer "three_pointers_attempted"
    t.decimal "three_pointers_percentage"
    t.integer "free_throws_made"
    t.integer "free_throws_attempted"
    t.decimal "free_throws_percentage"
    t.integer "offensive_rebounds"
    t.integer "defensive_rebounds"
    t.integer "rebounds"
    t.decimal "offensive_rebounds_percentage"
    t.decimal "defensive_rebounds_percentage"
    t.decimal "total_rebounds_percentage"
    t.integer "assists"
    t.integer "steals"
    t.integer "blocked_shots"
    t.integer "turnovers"
    t.integer "personal_fouls"
    t.integer "points"
    t.decimal "true_shooting_attempts"
    t.decimal "true_shooting_percentage"
    t.decimal "steals_percentage"
    t.decimal "blocks_percentage"
    t.decimal "turnovers_percentage"
    t.decimal "fantasy_points_fan_duel"
    t.bigint "season_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "school"
    t.integer "ap_rank"
    t.integer "conference_losses"
    t.integer "possessions"
    t.integer "season_type"
    t.integer "global_team_season_id"
    t.decimal "assists_percentage"
    t.decimal "three_pointers_per_field_goal_attempted"
    t.decimal "free_throws_per_field_goal_attempted"
    t.index ["global_team_season_id"], name: "index_team_seasons_on_global_team_season_id", unique: true
    t.index ["school"], name: "index_team_seasons_on_school"
    t.index ["season_id"], name: "index_team_seasons_on_season_id"
    t.index ["team_id", "season_id"], name: "index_team_seasons_on_team_id_and_season_id"
    t.index ["team_id"], name: "index_team_seasons_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "key"
    t.boolean "active"
    t.string "school"
    t.string "name"
    t.string "team_logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "conference_id"
    t.integer "global_team_id"
    t.integer "ap_rank"
    t.index ["conference_id"], name: "index_teams_on_conference_id"
    t.index ["global_team_id"], name: "index_teams_on_global_team_id"
    t.index ["key"], name: "index_teams_on_key", unique: true
    t.index ["school"], name: "index_teams_on_school"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.integer "account_level"
    t.date "expiration_date"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.integer "team_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "allowed_seasons", "team_seasons"
  add_foreign_key "games", "seasons"
  add_foreign_key "games", "team_seasons", column: "away_team_season_id"
  add_foreign_key "games", "team_seasons", column: "home_team_season_id"
  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "player_games", "games"
  add_foreign_key "player_games", "players"
  add_foreign_key "player_games", "team_games"
  add_foreign_key "player_games", "team_seasons"
  add_foreign_key "player_games", "teams"
  add_foreign_key "players", "teams"
  add_foreign_key "prophet_ratings", "team_seasons"
  add_foreign_key "team_games", "games"
  add_foreign_key "team_games", "team_seasons"
  add_foreign_key "team_games", "teams"
  add_foreign_key "team_seasons", "seasons"
  add_foreign_key "team_seasons", "teams"
end
