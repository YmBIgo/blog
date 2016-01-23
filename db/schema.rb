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

ActiveRecord::Schema.define(version: 20160123013322) do

  create_table "mentors", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "first_name",             limit: 255
    t.string   "family_name",            limit: 255
    t.integer  "age",                    limit: 4
    t.string   "belong",                 limit: 255
    t.text     "self_intro",             limit: 65535
    t.boolean  "sex"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "m_image_file_name",      limit: 255
    t.string   "m_image_content_type",   limit: 255
    t.integer  "m_image_file_size",      limit: 4
    t.datetime "m_image_updated_at"
  end

  add_index "mentors", ["email"], name: "index_mentors_on_email", unique: true, using: :btree
  add_index "mentors", ["reset_password_token"], name: "index_mentors_on_reset_password_token", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "first_name",             limit: 255
    t.string   "family_name",            limit: 255
    t.integer  "age",                    limit: 4
    t.string   "belong",                 limit: 255
    t.text     "self_intro",             limit: 65535
    t.integer  "venture_id",             limit: 4
    t.boolean  "sex"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "image_file_name",        limit: 255
    t.string   "image_content_type",     limit: 255
    t.integer  "image_file_size",        limit: 4
    t.datetime "image_updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "ventures", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.text     "explain",              limit: 65535
    t.text     "reason",               limit: 65535
    t.text     "vision",               limit: 65535
    t.text     "job_offer",            limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "v_image_file_name",    limit: 255
    t.string   "v_image_content_type", limit: 255
    t.integer  "v_image_file_size",    limit: 4
    t.datetime "v_image_updated_at"
    t.integer  "owner",                limit: 4
  end

end
