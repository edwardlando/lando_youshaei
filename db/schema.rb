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

ActiveRecord::Schema.define(:version => 20130201032239) do

  create_table "carts", :force => true do |t|
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "user_id"
  end

  create_table "channels", :force => true do |t|
    t.string   "apparel"
    t.string   "vibe"
    t.string   "price"
    t.string   "gender"
    t.datetime "created_at",                                                                                                                       :null => false
    t.datetime "updated_at",                                                                                                                       :null => false
    t.integer  "user_id"
    t.integer  "item_index"
    t.boolean  "current_channel"
    t.string   "guest_user_id"
    t.text     "genes",              :limit => 255, :default => "2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5"
    t.text     "seen",                              :default => ""
    t.decimal  "mean_gene_distance",                :default => 8.94427
  end

  create_table "confirmations", :force => true do |t|
    t.string    "name"
    t.text      "address"
    t.integer   "user_id"
    t.decimal   "total"
    t.timestamp "created_at",                    :null => false
    t.timestamp "updated_at",                    :null => false
    t.integer   "order_id"
    t.string    "status",     :default => "new"
  end

  create_table "item_votes", :force => true do |t|
    t.integer   "item_id"
    t.integer   "user_id"
    t.integer   "value"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "item_votes", ["item_id"], :name => "index_item_votes_on_item_id"
  add_index "item_votes", ["user_id"], :name => "index_item_votes_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "url"
    t.string   "apparel"
    t.decimal  "price"
    t.string   "gender"
    t.string   "vibe"
    t.integer  "user_id"
    t.text     "genes",      :limit => 255
  end

  create_table "items_wishlists", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "wishlist_id"
  end

  add_index "items_wishlists", ["item_id", "wishlist_id"], :name => "index_items_wishlists_on_item_id_and_wishlist_id"

  create_table "line_items", :force => true do |t|
    t.integer   "item_id"
    t.integer   "cart_id"
    t.timestamp "created_at",                          :null => false
    t.timestamp "updated_at",                          :null => false
    t.integer   "quantity",        :default => 1
    t.integer   "order_id"
    t.string    "current_url"
    t.string    "name"
    t.integer   "confirmation_id"
    t.decimal   "price"
    t.string    "size",            :default => "none"
  end

  create_table "orders", :force => true do |t|
    t.string    "name"
    t.text      "address"
    t.timestamp "created_at",            :null => false
    t.timestamp "updated_at",            :null => false
    t.string    "stripe_customer_token"
    t.integer   "user_id"
    t.integer   "confirmation_id"
    t.text      "shipping_address"
  end

  create_table "rs_evaluations", :force => true do |t|
    t.string    "reputation_name"
    t.integer   "source_id"
    t.string    "source_type"
    t.integer   "target_id"
    t.string    "target_type"
    t.float     "value",           :default => 0.0
    t.timestamp "created_at",                       :null => false
    t.timestamp "updated_at",                       :null => false
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], :name => "index_rs_evaluations_on_reputation_name_and_source_and_target", :unique => true
  add_index "rs_evaluations", ["reputation_name"], :name => "index_rs_evaluations_on_reputation_name"
  add_index "rs_evaluations", ["source_id", "source_type"], :name => "index_rs_evaluations_on_source_id_and_source_type"
  add_index "rs_evaluations", ["target_id", "target_type"], :name => "index_rs_evaluations_on_target_id_and_target_type"

  create_table "rs_reputation_messages", :force => true do |t|
    t.integer   "sender_id"
    t.string    "sender_type"
    t.integer   "receiver_id"
    t.float     "weight",      :default => 1.0
    t.timestamp "created_at",                   :null => false
    t.timestamp "updated_at",                   :null => false
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_receiver_id_and_sender", :unique => true
  add_index "rs_reputation_messages", ["receiver_id"], :name => "index_rs_reputation_messages_on_receiver_id"
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_sender_id_and_sender_type"

  create_table "rs_reputations", :force => true do |t|
    t.string    "reputation_name"
    t.float     "value",           :default => 0.0
    t.string    "aggregated_by"
    t.integer   "target_id"
    t.string    "target_type"
    t.boolean   "active",          :default => true
    t.timestamp "created_at",                        :null => false
    t.timestamp "updated_at",                        :null => false
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], :name => "index_rs_reputations_on_reputation_name_and_target", :unique => true
  add_index "rs_reputations", ["reputation_name"], :name => "index_rs_reputations_on_reputation_name"
  add_index "rs_reputations", ["target_id", "target_type"], :name => "index_rs_reputations_on_target_id_and_target_type"

  create_table "styles", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string    "email",                  :default => ""
    t.string    "encrypted_password",     :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                             :null => false
    t.timestamp "updated_at",                             :null => false
    t.string    "username"
    t.text      "about"
    t.string    "role"
    t.string    "stripe_customer_token"
    t.text      "address"
    t.text      "shipping_address"
    t.string    "provider"
    t.string    "uid"
    t.string    "lazy_id"
    t.integer   "rating",                 :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wishlists", :force => true do |t|
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "user_id"
  end

end
