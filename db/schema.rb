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

ActiveRecord::Schema.define(version: 2019_07_10_080813) do

  create_table "bedsore_parts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "part_genre"
    t.string "part_name"
    t.integer "common_part"
    t.bigint "patient_id"
    t.bigint "nurse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nurse_id"], name: "index_bedsore_parts_on_nurse_id"
    t.index ["patient_id"], name: "index_bedsore_parts_on_patient_id"
  end

  create_table "bedsores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.datetime "image_edited_at"
    t.bigint "image_editor_id"
    t.text "comment"
    t.string "handwrite_image"
    t.bigint "bedsore_part_id"
    t.bigint "nurse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bedsore_part_id"], name: "index_bedsores_on_bedsore_part_id"
    t.index ["image_editor_id"], name: "index_bedsores_on_image_editor_id"
    t.index ["nurse_id"], name: "index_bedsores_on_nurse_id"
  end

  create_table "care_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.datetime "image_edited_at"
    t.bigint "image_editor_id"
    t.text "comment"
    t.datetime "comment_edited_at"
    t.bigint "comment_editor_id"
    t.bigint "nurse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bedsore_part_id"
    t.index ["bedsore_part_id"], name: "index_care_infos_on_bedsore_part_id"
    t.index ["comment_editor_id"], name: "index_care_infos_on_comment_editor_id"
    t.index ["image_editor_id"], name: "index_care_infos_on_image_editor_id"
    t.index ["nurse_id"], name: "index_care_infos_on_nurse_id"
  end

  create_table "care_tools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "depressure_tools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "design_rs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "depth"
    t.decimal "size_minor_axis", precision: 10
    t.decimal "size_major_axis", precision: 10
    t.integer "inflammation"
    t.integer "granule_tissue"
    t.integer "necrotic_tissue"
    t.decimal "pocket_minor_axis", precision: 10
    t.decimal "pocket_major_axis", precision: 10
    t.bigint "bedsore_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bedsore_id"], name: "index_design_rs_on_bedsore_id"
  end

  create_table "nurses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "name_kana"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
  end

  create_table "patients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "name_kana"
    t.integer "age"
    t.integer "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "topics"
    t.bigint "topics_editor_id"
    t.datetime "topics_updated_at"
    t.string "image"
    t.bigint "image_editor_id"
    t.datetime "image_updated_at"
    t.index ["image_editor_id"], name: "index_patients_on_image_editor_id"
    t.index ["topics_editor_id"], name: "index_patients_on_topics_editor_id"
  end

  add_foreign_key "bedsore_parts", "nurses"
  add_foreign_key "bedsore_parts", "patients"
  add_foreign_key "bedsores", "bedsore_parts"
  add_foreign_key "bedsores", "nurses"
  add_foreign_key "bedsores", "nurses", column: "image_editor_id"
  add_foreign_key "care_infos", "bedsore_parts"
  add_foreign_key "care_infos", "nurses"
  add_foreign_key "care_infos", "nurses", column: "comment_editor_id"
  add_foreign_key "care_infos", "nurses", column: "image_editor_id"
  add_foreign_key "design_rs", "bedsores"
  add_foreign_key "patients", "nurses", column: "image_editor_id"
  add_foreign_key "patients", "nurses", column: "topics_editor_id"
end
