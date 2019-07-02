class PatientsController < ApplicationController
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

  # 新規作成メソッド
  def create
    @patient = Patient.new()
    # フォームの値取り出し
    form_params = params[:patient]
    @patient.name = form_params[:name]
    @patient.name_kana = form_params[:name_kana]
    @patient.age = form_params[:age]
    @patient.sex = form_params[:sex]
    if @patient.save()
      flash[:notice] = '新しく療養者を登録しました'
      redirect_to('/patients')
    else
      render('patients/new')
    end
  end

  # 更新メソッド
  def update
    @patient = Patient.find_by(id: params[:id])
    # フォームの値取り出し
    form_params = params[:patient]
    @patient.name = form_params[:name]
    @patient.name_kana = form_params[:name_kana]
    @patient.age = form_params[:age]
    @patient.sex = form_params[:sex]
    if @patient.save()
      flash[:notice] = '登録情報を更新しました'
      redirect_to("/patients/#{params[:id]}")
    else
      render("patients/#{params[:id]}/edit")
    end
  end

  # 削除メソッド
  def destroy
    @patient = Patient.find_by(id: params[:id])
    @patient.destroy()
    redirect_to('/patients')
  end
end
