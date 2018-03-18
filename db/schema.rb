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

ActiveRecord::Schema.define(version: 20180318141401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "seasons", force: :cascade do |t|
    t.integer "start_year"
    t.integer "end_year"
    t.string "description"
    t.date "regular_season_start_date"
    t.date "post_season_start_date"
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.decimal "assits_percentage"
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
    t.index ["season_id"], name: "index_team_seasons_on_season_id"
    t.index ["team_id", "season_id"], name: "index_team_seasons_on_team_id_and_season_id"
    t.index ["team_id"], name: "index_team_seasons_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "key"
    t.boolean "active"
    t.string "school"
    t.string "name"
    t.integer "ap_rank"
    t.string "team_logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "team_seasons", "seasons"
  add_foreign_key "team_seasons", "teams"
end
