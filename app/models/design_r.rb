class DesignR < ApplicationRecord
  belongs_to :bedsore

  # 深さ
  enum depth: { 
    "【d0】:皮膚損傷・発赤なし": 0, 
    "【d1】:持続する発赤": 1, 
    "【d2】:真皮までの損傷": 2, 
    "【D3】:皮下組織までの損傷": 3,
    "【D4】:皮下組織を超える損傷": 4,
    "【D5】:関節腔、体腔に至る損傷": 5,
    "【DU】:深さ判定が不能の場合": 6 
  }

  # 滲出液
  enum exudate:{
    "【e0】:なし": 0, 
    "【e1】:少量（毎日の交換の必要なし）": 1, 
    "【e3】:中等量(1日１回交換が必要)": 2, 
    "【E6】:多量(1日2回以上の交換が必要)": 3,
  }

  # 炎症/感染
  enum inflammation:{
    "【i0】:局所の炎症徴候": 0, 
    "【i1】:局所の炎症徴候あり(創周囲の発赤、腫脹、熱感)": 1, 
    "【i3】:局所の明らかな感染徴候あり（炎症徴候、膿、悪臭など）": 2, 
    "【Ii】:全身的影響あり(発熱など)": 3,
  }

  # 肉芽組織
  enum granule_tissue: { 
    "【g0】:治癒あるいは創が浅いため肉芽形成の評価ができない": 0, 
    "【g1】:良性肉芽が創面の90%以上を占める": 1, 
    "【g3】:良性肉芽が創面の50%以上90%未満を占める": 2, 
    "【G4】:良性肉芽が創面の10%以上50%未満を占める": 3,
    "【G5】:良性肉芽が創面の10%未満を占める": 4,
    "【G6】:良性肉芽が全く形成されていない": 5,
  }

  # 壊死組織
  enum necrotic_tissue:{
    "【n0】:壊死組織なし": 0, 
    "【n3】:柔らかい壊死組織あり": 1, 
    "【N6】:硬く暑い密着した壊死組織あり": 2, 
  }

  # コントローラーから渡されたparamでカラムを更新する
  def update(params)
    self.depth = params[:depth]
    self.exudate = params[:exudate]
    self.size_minor_axis = params[:size_minor_axis]
    self.size_major_axis = params[:size_major_axis]
    self.inflammation = params[:inflammation]
    self.granule_tissue = params[:granule_tissue]
    self.necrotic_tissue = params[:necrotic_tissue]
    self.pocket_minor_axis = params[:pocket_minor_axis]
    self.pocket_major_axis = params[:pocket_major_axis]
  end

end
