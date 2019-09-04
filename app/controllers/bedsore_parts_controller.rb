class BedsorePartsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check

  # 一覧ページ
  def index; end

  # 新規作成ページ
  def show; end

  # 詳細ページ
  def new; end

  # 編集ページ
  def edit; end

  # 新規作成
  def create
    @patient = Patient.find(params[:patient_id])
    bedsore_part = @patient.bedsore_parts.build()
    bedsore_part.update(params, current_nurse)
    if bedsore_part.save()
      flash[:primary] = '新しく褥瘡部位を登録しました'
      redirect_back(fallback_location: root_path)
    end
  end

  # 登録情報更新
  def update; end

  # 削除
  def destroy
    @bedsore_part = BedsorePart.find(params[:id])
    redirect_back(fallback_location: root_path) if @bedsore_part.destroy()
  end
end
