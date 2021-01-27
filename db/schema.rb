# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_27_003541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anon_users", force: :cascade do |t|
    t.string "nickname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bishops", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "boards", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_boards_on_game_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "team_id", null: false
    t.bigint "game_id", null: false
    t.index ["game_id"], name: "index_channels_on_game_id"
    t.index ["team_id"], name: "index_channels_on_team_id"
  end

  create_table "game_masters", force: :cascade do |t|
    t.boolean "running"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "gameover"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "kings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "knights", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "author_type", null: false
    t.bigint "author_id", null: false
    t.index ["author_type", "author_id"], name: "index_messages_on_author_type_and_author_id"
    t.index ["channel_id"], name: "index_messages_on_channel_id"
  end

  create_table "moves", force: :cascade do |t|
    t.bigint "start_id", null: false
    t.bigint "end_id", null: false
    t.bigint "team_id", null: false
    t.bigint "piece_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id", null: false
    t.index ["end_id"], name: "index_moves_on_end_id"
    t.index ["game_id"], name: "index_moves_on_game_id"
    t.index ["piece_id"], name: "index_moves_on_piece_id"
    t.index ["start_id"], name: "index_moves_on_start_id"
    t.index ["team_id"], name: "index_moves_on_team_id"
  end

  create_table "pawns", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pieces", force: :cascade do |t|
    t.string "type"
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_pieces_on_team_id"
  end

  create_table "plays", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "team_id", null: false
    t.string "player_type", null: false
    t.bigint "player_id", null: false
    t.boolean "active", null: false
    t.index ["game_id"], name: "index_plays_on_game_id"
    t.index ["player_type", "player_id"], name: "index_plays_on_player_type_and_player_id"
    t.index ["team_id"], name: "index_plays_on_team_id"
  end

  create_table "queens", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooks", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spaces", force: :cascade do |t|
    t.integer "row"
    t.integer "column"
    t.bigint "board_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "piece_id"
    t.bigint "team_id", null: false
    t.index ["board_id"], name: "index_spaces_on_board_id"
    t.index ["piece_id"], name: "index_spaces_on_piece_id"
    t.index ["team_id"], name: "index_spaces_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "colour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "game_id", null: false
    t.index ["game_id"], name: "index_teams_on_game_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "chat_colour"
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "boards", "games"
  add_foreign_key "channels", "games"
  add_foreign_key "channels", "teams"
  add_foreign_key "messages", "channels"
  add_foreign_key "moves", "games"
  add_foreign_key "moves", "pieces"
  add_foreign_key "moves", "spaces", column: "end_id"
  add_foreign_key "moves", "spaces", column: "start_id"
  add_foreign_key "moves", "teams"
  add_foreign_key "pieces", "teams"
  add_foreign_key "plays", "games"
  add_foreign_key "plays", "teams"
  add_foreign_key "spaces", "boards"
  add_foreign_key "spaces", "pieces"
  add_foreign_key "spaces", "teams"
  add_foreign_key "teams", "games"
end
