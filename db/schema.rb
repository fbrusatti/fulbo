# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130627222046) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "affiliations", :force => true do |t|
    t.integer  "league_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "affiliations", ["league_id", "team_id"], :name => "index_affiliations_on_league_id_and_team_id", :unique => true
  add_index "affiliations", ["league_id"], :name => "index_affiliations_on_league_id"
  add_index "affiliations", ["team_id"], :name => "index_affiliations_on_team_id"

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
  end

  create_table "cards", :force => true do |t|
    t.integer  "match_id"
    t.integer  "team_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "cards", ["match_id"], :name => "index_cards_on_match_id"
  add_index "cards", ["team_user_id"], :name => "index_cards_on_team_user_id"

  create_table "fields", :force => true do |t|
    t.integer  "location_id"
    t.string   "name"
    t.string   "surface"
    t.string   "category"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.string   "description"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "fixtures", :force => true do |t|
    t.integer  "league_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "goals", :force => true do |t|
    t.integer  "match_id"
    t.integer  "team_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "goals", ["match_id"], :name => "index_goals_on_match_id"
  add_index "goals", ["team_user_id"], :name => "index_goals_on_team_user_id"

  create_table "leagues", :force => true do |t|
    t.integer  "organizer_id"
    t.string   "name"
    t.string   "category"
    t.integer  "number_matches"
    t.decimal  "field_price",        :precision => 8, :scale => 2
    t.decimal  "registration_price", :precision => 8, :scale => 2
    t.string   "requirements"
    t.integer  "number_teams"
    t.date     "start_date"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "leagues", ["organizer_id"], :name => "index_leagues_on_organizer_id"

  create_table "locations", :force => true do |t|
    t.integer  "sport_center_id"
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "locality"
    t.string   "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "matches", :force => true do |t|
    t.integer  "visitor_id"
    t.integer  "local_id"
    t.integer  "week_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "matches", ["local_id"], :name => "index_matches_on_local_id"
  add_index "matches", ["visitor_id"], :name => "index_matches_on_visitor_id"
  add_index "matches", ["week_id"], :name => "index_matches_on_week_id"

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "point_systems", :force => true do |t|
    t.integer  "league_id"
    t.integer  "win",        :default => 3
    t.integer  "tie",        :default => 1
    t.integer  "loose",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "match_id"
    t.integer  "field_id"
    t.datetime "reservation_date"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "reservations", ["field_id"], :name => "index_reservations_on_field_id"
  add_index "reservations", ["match_id"], :name => "index_reservations_on_match_id"

  create_table "sport_centers", :force => true do |t|
    t.string   "name"
    t.string   "cuit"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "owner_id"
  end

  create_table "team_profiles", :force => true do |t|
    t.integer  "team_id"
    t.string   "category"
    t.string   "surface"
    t.string   "geo_availability"
    t.string   "badge"
    t.string   "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "team_users", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "team_users", ["team_id", "user_id"], :name => "index_team_users_on_team_id_and_user_id", :unique => true
  add_index "team_users", ["team_id"], :name => "index_team_users_on_team_id"
  add_index "team_users", ["user_id"], :name => "index_team_users_on_user_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "captain"
    t.integer  "owner_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "teams", ["owner_id"], :name => "index_teams_on_owner_id"
  add_index "teams", ["slug"], :name => "index_teams_on_slug"

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "surname"
    t.string   "nickname"
    t.string   "playing_position"
    t.string   "locality"
    t.string   "foot"
    t.string   "features"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "avatar"
    t.date     "dob"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "slug"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug"

  create_table "weeks", :force => true do |t|
    t.integer  "fixture_id"
    t.integer  "number"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "weeks", ["fixture_id"], :name => "index_weeks_on_fixture_id"

end
