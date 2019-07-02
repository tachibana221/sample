class NursesController < ApplicationController
  # 一覧ページ
  def index
    @nurses = Nurse.all()
  end

  # 詳細ページ
  def show
    @nurse = Nurse.find_by(id: params[:id])
  end

  # 新規作成ページ
  def new
    @nurse = Nurse.new()
  end

  # 編集ページ
  def edit
    @nurse = Nurse.find_by(id: params[:id])
  end

  # 新規作成メソッド
  def create
    @nurse = Nurse.new()
    # フォームの値取り出し
    form_params = params[:nurse]
    @nurse.name = form_params[:name]
    @nurse.name_kana = form_params[:name_kana]
    @nurse.password = form_params[:password]
    @nurse.password_confirmation = form_params[:password_confirmation]
    if @nurse.save()
      flash[:notice] = '新しく看護師を登録しました'
      redirect_to('/nurses')
    else
      render('nurses/new')
    end
  end

  # 更新メソッド
  def update
    @nurse = Nurse.find_by(id: params[:id])
    # フォームの値取り出し
    form_params = params[:nurse]
    @nurse.name = form_params[:name]
    @nurse.name_kana = form_params[:name_kana]
    
    # パスワードが入力されていたら更新する
    if @nurse.password &&	 @nurse.password_confirmation
      @nurse.password = form_params[:password]
      @nurse.password_confirmation = form_params[:password_confirmation]
    end

    if @nurse.save()
      flash[:notice] = '登録情報を更新しました'
      redirect_to("/nurses/#{params[:id]}")
    else
      render("nurses/#{params[:id]}/edit")
    end
  end

  # 削除メソッド
  def destroy
    @nurse = Nurse.find_by(id: params[:id])
    @nurse.destroy()
    redirect_to('/nurses')
  end
end
