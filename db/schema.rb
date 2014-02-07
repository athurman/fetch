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

ActiveRecord::Schema.define(version: 20140205141600) do

  create_table "breeds", force: true do |t|
    t.string  "name"
    t.string  "size"
    t.string  "lifespan"
    t.string  "weight"
    t.string  "height"
    t.integer "group_id"
    t.string  "exercise"
    t.string  "grooming"
    t.string  "family_friendly"
    t.integer "role_id"
    t.string  "temperament"
  end

  create_table "groups", force: true do |t|
    t.string "name"
  end

  create_table "roles", force: true do |t|
    t.string "name"
  end

  create_table "shelterdogs", force: true do |t|
    t.string "name"
    t.string "breed"
    t.string "shelter"
    t.string "age"
    t.string "weight"
    t.string "status"
  end

  create_table "shelters", force: true do |t|
    t.string  "name"
    t.integer "location"
    t.string  "petfinder_id"
  end

end
