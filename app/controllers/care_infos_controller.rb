class CareInfosController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check

  # 一覧ページ
  def index
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
  end

  # 詳細ページ
  def show
    care_info_id = params[:id]
    @care_info = CareInfo.find(care_info_id)
  end

  # 新規作成ページ
  def new
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
  end

  # 編集ページ
  def edit
    care_info_id = params[:id]
    @care_info = CareInfo.find(care_info_id)
  end
 
  def move_higher
    bedsore_part_id = params[:bedsore_part_id]
    CareInfo.find(params[:id]).move_higher
    redirect_to action: 'index', bedsore_part_id: bedsore_part_id
  end
 
  def move_lower
    bedsore_part_id = params[:bedsore_part_id]
    CareInfo.find(params[:id]).move_lower
    redirect_to action: 'index', bedsore_part_id: bedsore_part_id
  end

  # 新規作成
  def create
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
    care_info = @bedsore_part.care_infos.build()
    care_info.update(params, current_nurse)
    if care_info.save()
      flash[:primary] = '新しくケア情報を登録しました'
      redirect_to action: 'index', bedsore_part_id: bedsore_part_id
    end
  end

  # 登録情報更新
  def update
    @care_info = CareInfo.find(params[:id])
    @care_info.update(params[:care_info], current_nurse)
    if @care_info.save()
      flash[:primary] = 'ケア情報を更新しました'
      redirect_to action: 'index', bedsore_part_id: @care_info.bedsore_part.id
    end
  end

  # 削除
  def destroy
    @careinfo = CareInfo.find(params[:id])
    redirect_back(fallback_location: root_path) if @careinfo.destroy()
  end
end
