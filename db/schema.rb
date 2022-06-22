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

ActiveRecord::Schema.define(version: 20220622100345) do

  create_table "collection_members", force: :cascade do |t|
    t.integer "collection_id", limit: 4
    t.integer "target_id",     limit: 4
    t.string  "type",          limit: 255
  end

  add_index "collection_members", ["collection_id", "target_id", "type"], name: "ix_collections_fk_type", using: :btree
  add_index "collection_members", ["target_id"], name: "fk_rails_2a51b48094", using: :btree

  create_table "concept_relations", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.integer  "owner_id",   limit: 4
    t.integer  "target_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank",       limit: 4,   default: 100
  end

  add_index "concept_relations", ["owner_id", "target_id"], name: "ix_concept_relations_fk", using: :btree
  add_index "concept_relations", ["target_id"], name: "fk_rails_fd6c6e6fd7", using: :btree

  create_table "concepts", force: :cascade do |t|
    t.string   "type",                 limit: 255
    t.string   "origin",               limit: 4000
    t.integer  "rev",                  limit: 4,    default: 1
    t.date     "published_at"
    t.integer  "published_version_id", limit: 4
    t.integer  "locked_by",            limit: 4
    t.date     "expired_at"
    t.date     "follow_up"
    t.boolean  "to_review"
    t.date     "rdf_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "top_term",                          default: false
  end

  add_index "concepts", ["locked_by"], name: "fk_rails_69655c7fd3", using: :btree
  add_index "concepts", ["origin"], name: "ix_concepts_on_origin", length: {"origin"=>255}, using: :btree
  add_index "concepts", ["published_version_id"], name: "ix_concepts_publ_version_id", using: :btree

  create_table "configuration_settings", force: :cascade do |t|
    t.string "key",   limit: 255
    t.string "value", limit: 255
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",                    limit: 4,     default: 0, null: false
    t.integer  "attempts",                    limit: 4,     default: 0, null: false
    t.text     "handler",                     limit: 65535,             null: false
    t.text     "last_error",                  limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",                   limit: 255
    t.string   "queue",                       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "error_message",               limit: 255
    t.string   "delayed_reference_type",      limit: 255
    t.integer  "delayed_reference_id",        limit: 4
    t.string   "delayed_global_reference_id", limit: 255
  end

  add_index "delayed_jobs", ["delayed_global_reference_id"], name: "delayed_jobs_delayed_global_reference_id", using: :btree
  add_index "delayed_jobs", ["delayed_reference_id"], name: "delayed_jobs_delayed_reference_id", using: :btree
  add_index "delayed_jobs", ["delayed_reference_type"], name: "delayed_jobs_delayed_reference_type", using: :btree
  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["queue"], name: "delayed_jobs_queue", using: :btree

  create_table "exports", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.text     "output",            limit: 65535
    t.boolean  "success",                         default: false
    t.integer  "file_type",         limit: 4
    t.string   "token",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "finished_at"
    t.string   "default_namespace", limit: 255
  end

  add_index "exports", ["user_id"], name: "index_exports_on_user_id", using: :btree

  create_table "imports", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.text     "output",            limit: 65535
    t.boolean  "success",                         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "finished_at"
    t.string   "import_file",       limit: 255
    t.boolean  "publish"
    t.string   "default_namespace", limit: 255
  end

  add_index "imports", ["user_id"], name: "index_imports_on_user_id", using: :btree

  create_table "labelings", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.integer  "owner_id",   limit: 4
    t.integer  "target_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labelings", ["owner_id", "target_id", "type"], name: "ix_labelings_fk_type", using: :btree
  add_index "labelings", ["target_id"], name: "fk_rails_5897707e64", using: :btree
  add_index "labelings", ["type"], name: "ix_labelings_on_type", using: :btree

  create_table "labels", force: :cascade do |t|
    t.string   "type",         limit: 255
    t.string   "origin",       limit: 4000
    t.string   "language",     limit: 255
    t.string   "value",        limit: 1024
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "published_at"
  end

  add_index "labels", ["language"], name: "ix_labels_on_language", using: :btree
  add_index "labels", ["origin"], name: "ix_labels_on_origin", length: {"origin"=>255}, using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "concept_id", limit: 4
    t.string   "type",       limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["concept_id", "type"], name: "ix_matches_fk_type", using: :btree
  add_index "matches", ["type"], name: "ix_matches_on_type", using: :btree

  create_table "notations", force: :cascade do |t|
    t.integer "concept_id", limit: 4
    t.string  "value",      limit: 4000
    t.string  "data_type",  limit: 4000
  end

  add_index "notations", ["concept_id"], name: "index_notations_on_concept_id", using: :btree

  create_table "note_annotations", force: :cascade do |t|
    t.integer  "note_id",    limit: 4
    t.string   "predicate",  limit: 50
    t.string   "value",      limit: 1024
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace",  limit: 50
    t.string   "language",   limit: 255
  end

  add_index "note_annotations", ["note_id"], name: "ix_note_annotations_fk", using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "language",   limit: 2
    t.string   "value",      limit: 4000
    t.string   "type",       limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id",   limit: 4
    t.string   "owner_type", limit: 255,  null: false
  end

  add_index "notes", ["language"], name: "ix_notes_on_language", using: :btree
  add_index "notes", ["owner_id", "owner_type", "type"], name: "ix_notes_fk_type", using: :btree
  add_index "notes", ["type"], name: "ix_notes_on_type", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "forename",          limit: 255
    t.string   "surname",           limit: 255
    t.string   "email",             limit: 255
    t.string   "crypted_password",  limit: 255
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_salt",     limit: 255
    t.string   "persistence_token", limit: 255
    t.string   "perishable_token",  limit: 255
    t.string   "role",              limit: 255
    t.string   "telephone_number",  limit: 255
    t.string   "type",              limit: 255, default: "User"
  end

  create_table "vocabulary_exports", force: :cascade do |t|
    t.string   "token",       limit: 255
    t.text     "log",         limit: 65535
    t.boolean  "success",                   default: false
    t.datetime "finished_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "spoiled",                   default: false
  end

  add_foreign_key "collection_members", "concepts", column: "collection_id", on_update: :cascade
  add_foreign_key "collection_members", "concepts", column: "target_id", on_update: :cascade
  add_foreign_key "concept_relations", "concepts", column: "owner_id", on_update: :cascade
  add_foreign_key "concept_relations", "concepts", column: "target_id", on_update: :cascade
  add_foreign_key "concepts", "users", column: "locked_by", on_update: :cascade, on_delete: :nullify
  add_foreign_key "exports", "users", on_update: :cascade, on_delete: :nullify
  add_foreign_key "imports", "users", on_update: :cascade, on_delete: :nullify
  add_foreign_key "labelings", "concepts", column: "owner_id", on_update: :cascade
  add_foreign_key "labelings", "labels", column: "target_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "matches", "concepts", on_update: :cascade, on_delete: :cascade
  add_foreign_key "notations", "concepts", on_update: :cascade
  add_foreign_key "note_annotations", "notes", on_update: :cascade, on_delete: :cascade
end
