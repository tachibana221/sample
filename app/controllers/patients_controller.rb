# 療養者コントローラー
require 'date'
class PatientsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check

  # 一覧ページ
  def index
    @patients = Patient.all()
  end

  # 詳細ページ
  def show
    @patient = Patient.find_by(id: params[:id])
  end

  # 新規作成ページ
  def new
    @patient = Patient.new()
  end

  # 編集ページ
  def edit
    @patient = Patient.find_by(id: params[:id])
  end

  # 編集ページ
  def image_form
    @patient = Patient.find_by(id: params[:id])
  end

  # 新規作成メソッド
  def create
    @patient = Patient.new()
    # フォームの値取り出し
    @patient.update(params[:patient], current_nurse)
    using_care_tool = @patient.build_using_care_tool
    if @patient.save() && using_care_tool.save()
      flash[:primary] = '新しく療養者を登録しました'
      redirect_to('/patients')
    else
      render('patients/new')
    end
  end

  # 更新メソッド
  def update
    @patient = Patient.find_by(id: params[:id])
    # フォームの値取り出し
    @patient.update(params[:patient], current_nurse)
    if @patient.save()
      flash[:primary] = '登録情報を更新しました'
      redirect_to("/patients/#{params[:id]}")
    else
      render("patients/edit")
    end
  end

  def upload_image
    @patient = Patient.find_by(id: params[:id])
    # フォームの値取り出し
    @patient.uploadImage(params, current_nurse)
    if @patient.save()
      flash[:primary] = '登録情報を更新しました'
      redirect_to("/patients/#{params[:id]}")
    else
      render("patients/edit")
    end
  end

  # 削除メソッド
  def destroy
    @patient = Patient.find_by(id: params[:id])
    @patient.destroy()
    redirect_to('/patients')
  end
end
