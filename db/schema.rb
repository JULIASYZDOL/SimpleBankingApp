# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_02_003605) do
  create_table "accounts", force: :cascade do |t|
    t.string "account_number"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "balance", default: 100
    t.text "account_number_ciphertext"
    t.text "account_number_iv"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "password_combinations", force: :cascade do |t|
    t.string "combination"
    t.text "character_positions"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "combination_ciphertext"
    t.text "combination_iv"
    t.index ["user_id"], name: "index_password_combinations_on_user_id"
  end

  create_table "password_reset_tokens", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "token"
    t.datetime "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_password_reset_tokens_on_user_id"
  end

  create_table "receivers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "receiver_id"
  end

  create_table "senders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sender_id"
  end

  create_table "sensitive_data", force: :cascade do |t|
    t.string "card_number"
    t.string "identity_document"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sensitive_data_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recipient_account_number"
    t.string "recipient_name"
    t.integer "sender_id", null: false
    t.integer "receiver_id", null: false
    t.index ["receiver_id"], name: "index_transactions_on_receiver_id"
    t.index ["sender_id"], name: "index_transactions_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "card_number"
    t.string "identity_document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mail"
    t.text "encrypted_selected_characters"
    t.text "account_number_ciphertext"
    t.text "account_number_iv"
    t.text "card_number_ciphertext"
    t.text "card_number_iv"
    t.text "encrypted_identity_document"
    t.text "encrypted_identity_document_iv"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "password_combinations", "users"
  add_foreign_key "password_reset_tokens", "users"
  add_foreign_key "sensitive_data", "users"
  add_foreign_key "transactions", "accounts", column: "receiver_id"
  add_foreign_key "transactions", "accounts", column: "sender_id"
end
