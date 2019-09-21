class BedsoresController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check

  # 一覧ページ
  def index
    bedsore_part_id = params[:bedsore_part_id] ? params[:bedsore_part_id] : params[:bedsore][:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
  end

  # 新規作成ページ
  def show
    bedsore_id = params[:id]
    @bedsore = Bedsore.find(bedsore_id)
  end

  # 新規作成ページ
  def new
    bedsore_part_id = params[:bedsore_part_id]
    bedsore_part = BedsorePart.find(bedsore_part_id)
    # リレーションを持った褥瘡除法を作成
    @bedsore = bedsore_part.bedsores.build()
  end

  # 編集ページ
  def edit
    bedsore_id = params[:id]
    @bedsore = Bedsore.find(bedsore_id)
  end

  # 手書き入力ページ
  def paint
    bedsore_id = params[:id]
    @bedsore = Bedsore.find(bedsore_id)
  end

  # 新規作成
  def create
    bedsore_part_id = params[:bedsore][:bedsore_part_id]
    bedsore_part = BedsorePart.find(bedsore_part_id)
    bedsore = bedsore_part.bedsores.build()
    bedsore.update(params[:bedsore], current_nurse)
    # 紐づくDesign_Rモデルを作る
    design_r = bedsore.build_design_r
    if bedsore.save() && design_r.save()
      flash[:primary] = '新しく褥瘡情報を登録しました'
      redirect_to action: 'index', bedsore_part_id: bedsore_part_id
    else
      # エラー文を入れて新規登録画面に飛ばす
      flash[:danger] = bedsore.errors.full_messages.join("<br>")
      redirect_to action: 'new', bedsore_part_id: bedsore_part_id    
    end
  end

  # 登録情報更新
  def update
    @bedsore = Bedsore.find(params[:id])
    @bedsore.update(params[:bedsore], current_nurse)
    @bedsore.updateComments(params[:bedsore][:comments]) if params[:bedsore][:comments]
    if @bedsore.save()
      flash[:primary] = '褥瘡情報を更新しました'
      redirect_to("/bedsores/#{params[:id]}")
    else
      # エラー文を入れて新規登録画面に飛ばす
      flash[:danger] = @bedsore.errors.full_messages.join("<br>")
    end
  end

  # 削除
  def destroy
    @bedsore = Bedsore.find(params[:id])
    if @bedsore.destroy()
      redirect_to action: 'index', bedsore_part_id: @bedsore.bedsore_part.id 
    end
  end
end
