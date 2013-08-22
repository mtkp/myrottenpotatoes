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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130822011541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "moviegoers", force: true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",      default: false
    t.string   "image"
  end

  add_index "moviegoers", ["uid", "provider"], name: "index_moviegoers_on_uid_and_provider", using: :btree

  create_table "movies", force: true do |t|
    t.string   "title"
    t.string   "rating"
    t.text     "description"
    t.datetime "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tmdb_id"
  end

  add_index "movies", ["title"], name: "index_movies_on_title", using: :btree
  add_index "movies", ["tmdb_id"], name: "index_movies_on_tmdb_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "potatoes"
    t.text     "comments"
    t.integer  "moviegoer_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["moviegoer_id", "movie_id"], name: "index_reviews_on_moviegoer_id_and_movie_id", using: :btree

end
