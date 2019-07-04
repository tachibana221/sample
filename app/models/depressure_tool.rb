class DepressureTool < ApplicationRecord
  enum type: { "その他": 0, "ベッド": 1, "車椅子": 2 }
end
