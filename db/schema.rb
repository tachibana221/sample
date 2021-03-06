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

ActiveRecord::Schema.define(version: 2019_09_20_120830) do

  create_table "assign_care_tools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "using_care_tool_id"
    t.bigint "care_tool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["care_tool_id"], name: "index_assign_care_tools_on_care_tool_id"
    t.index ["using_care_tool_id"], name: "index_assign_care_tools_on_using_care_tool_id"
  end

  create_table "assign_depressure_tools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "using_depressure_tool_id"
    t.bigint "depressure_tool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["depressure_tool_id"], name: "index_assign_depressure_tools_on_depressure_tool_id"
    t.index ["using_depressure_tool_id"], name: "index_assign_depressure_tools_on_using_depressure_tool_id"
  end

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
    t.integer "position"
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

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.integer "position_x"
    t.integer "position_y"
    t.bigint "bedsore_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bedsore_id"], name: "index_comments_on_bedsore_id"
  end

  create_table "depressure_tools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "design_rs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "depth", default: 0
    t.integer "exudate", default: 0
    t.decimal "size_minor_axis", precision: 6, scale: 1, default: "0.0"
    t.decimal "size_major_axis", precision: 6, scale: 1, default: "0.0"
    t.integer "inflammation", default: 0
    t.integer "granule_tissue", default: 0
    t.integer "necrotic_tissue", default: 0
    t.decimal "pocket_minor_axis", precision: 6, scale: 1, default: "0.0"
    t.decimal "pocket_major_axis", precision: 6, scale: 1, default: "0.0"
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

  create_table "using_care_tools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "comment"
    t.string "image"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_using_care_tools_on_patient_id"
  end

  create_table "using_depressure_tools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "comment"
    t.string "image"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_using_depressure_tools_on_patient_id"
  end

  add_foreign_key "assign_care_tools", "care_tools"
  add_foreign_key "assign_care_tools", "using_care_tools"
  add_foreign_key "assign_depressure_tools", "depressure_tools"
  add_foreign_key "assign_depressure_tools", "using_depressure_tools"
  add_foreign_key "bedsore_parts", "nurses"
  add_foreign_key "bedsore_parts", "patients"
  add_foreign_key "bedsores", "bedsore_parts"
  add_foreign_key "bedsores", "nurses"
  add_foreign_key "bedsores", "nurses", column: "image_editor_id"
  add_foreign_key "care_infos", "bedsore_parts"
  add_foreign_key "care_infos", "nurses"
  add_foreign_key "care_infos", "nurses", column: "comment_editor_id"
  add_foreign_key "care_infos", "nurses", column: "image_editor_id"
  add_foreign_key "comments", "bedsores"
  add_foreign_key "design_rs", "bedsores"
  add_foreign_key "patients", "nurses", column: "image_editor_id"
  add_foreign_key "patients", "nurses", column: "topics_editor_id"
  add_foreign_key "using_care_tools", "patients"
  add_foreign_key "using_depressure_tools", "patients"
end
