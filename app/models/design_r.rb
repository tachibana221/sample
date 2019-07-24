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
    "【I9】:全身的影響あり(発熱など)": 3,
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

  # 以下DesingRのスコアを求めるロジック

  # 「【d0】:皮膚損傷・発赤なし」みたいな文字列から「d0」みたいなコードを取り出す
  def extractCode(str)
    return str[/【(.*?)】/, 1]
  end

  # 深さのスコア算出
  def calcDepthScore()
    depth = self.depth
    depthCode = self.extractCode(depth)
    score = 
      case depthCode
        when 'd0' then 0
        when 'd1' then 1
        when 'd2' then 2
        when 'D3' then 3
        when 'D4' then 4
        when 'D5' then 5
        when 'DU' then 5
        else 0
      end
    return score
  end

  # 滲出液のスコア算出
  def calcExudateScore()
    exudate = self.exudate
    exudateCode = self.extractCode(exudate)
    score = 
      case exudateCode
        when 'e0' then 0
        when 'e1' then 1
        when 'e3' then 3
        when 'E6' then 6
        else 0
      end
    return score
  end

  # 大きさのスコアを算出
  def clacSizeScore
    minor_axis = self.size_minor_axis
    major_axis = self.size_major_axis
    size = major_axis * minor_axis
    score = 
      case size
        when 0 then 0
        when 1..4 then 3
        when 4..16 then 6
        when 16..36 then 8
        when 36..64 then 9
        when 64..100 then 12
        else 15
      end
    return score
  end

  # 大きさのスコアから対応するコードを取得
  def getSizeCode
    score = self.clacSizeScore()
    code =
      case score
        when 0 then 's0'
        when 3 then 's3'
        when 6 then 's6'
        when 8 then 's8'
        when 9 then 's9'
        when 12 then 's12'
        else 'S15'
      end
    return code
  end

  # 炎症/感染のスコア算出
  def calcInflammationScore
    inflammation = self.inflammation
    inflammationCode = self.extractCode(inflammation)
    score = 
      case inflammationCode
        when 'i0' then 0
        when 'i1' then 1
        when 'I3' then 3
        when 'I9' then 9
        else 0
      end
    return score
  end

  # 肉芽組織のスコア算出
  def calcGranuleTissueScore
    granule_tissue = self.granule_tissue
    granule_tissueCode = self.extractCode(granule_tissue)
    score = 
      case granule_tissueCode
        when 'g0' then 0
        when 'g1' then 1
        when 'g3' then 3
        when 'G4' then 4
        when 'G5' then 5
        when 'G6' then 6
        else 0
      end
    return score
  end

  # 壊死組織のスコア算出
  def calcNecroticTissueScore
    necrotic_tissue = self.necrotic_tissue
    necrotic_tissueCode = self.extractCode(necrotic_tissue)
    score = 
      case necrotic_tissueCode
        when 'n0' then 0
        when 'N3' then 3
        when 'N6' then 6
        else 0
      end
    return score
  end

  # ポケットのスコアを算出
  def calcPocketScore
    minor_axis = self.pocket_minor_axis
    major_axis = self.pocket_major_axis
    size = major_axis * minor_axis - self.clacSizeScore
    score = 
      case size
        when 0 then 0
        when 1..4 then 6
        when 4..16 then 9
        when 16..36 then 12
        else 24
      end
    return score
  end

  # ポケットのスコアから対応するコードを取得
  def getPocketCode
    score = self.clacSizeScore()
    code =
      case score
        when 0 then 'p0'
        when 6 then 'P6'
        when 9 then 'P9'
        when 12 then 'P12'
        else 'P24'
      end
    return code
  end

  # 合計スコアを算出
  # 深さのスコアは使用しない
  def calcDesignRScore
    return self.calcExudateScore() + self.clacSizeScore() + self.calcInflammationScore() + 
      self.calcGranuleTissueScore() + self.calcNecroticTissueScore() + self.calcPocketScore()
  end

  # 合計コードを取得
  def getDesignRCode
    return self.extractCode(self.depth) + "-" + self.extractCode(self.exudate) + self.getSizeCode() + self.extractCode(self.inflammation) + 
      self.extractCode(self.granule_tissue) + self.extractCode(self.necrotic_tissue) + "-" + self.getPocketCode() 
  end

end
