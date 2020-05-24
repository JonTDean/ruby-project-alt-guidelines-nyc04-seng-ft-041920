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

ActiveRecord::Schema.define(version: 2020_05_24_064928) do

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
    t.integer "unit_id"
    t.float "amount"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "category"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
  end

end