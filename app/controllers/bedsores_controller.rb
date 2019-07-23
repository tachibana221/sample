class BedsoresController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check
  
  def index
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
  end

  def show
    bedsore_id = params[:id]
    @bedsore = Bedsore.find(bedsore_id)
  end

  def new
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
  end

  def edit
    bedsore_id = params[:id]
    @bedsore = Bedsore.find(bedsore_id)  
  end

  def paint
    bedsore_id = params[:id]
    @bedsore = Bedsore.find(bedsore_id)  
  end

  def create
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
    bedsore = @bedsore_part.bedsores.build()
    bedsore.update(params, current_nurse)
    # 紐づくDesign_Rモデルを作る
    design_r = bedsore.build_design_r
    if bedsore.save() && design_r.save()
      flash[:primary] = '新しく褥瘡情報を登録しました'
      redirect_to :action => "index", :bedsore_part_id => bedsore_part_id
    end
  end

  def update
    @bedsore = Bedsore.find(params[:id])
    @bedsore.update(params[:bedsore], current_nurse)
    @bedsore.updateComments(params[:bedsore][:comments]) if params[:bedsore][:comments]
    if @bedsore.save()
      flash[:primary] = '褥瘡情報を更新しました'
      redirect_to("/bedsores/#{params[:id]}")
    end
  end

  def destroy
    @bedsore = Bedsore.find(params[:id])
    if @bedsore.destroy()
      redirect_to :action => "index", :bedsore_part_id => @bedsore.bedsore_part.id
    end
  end
end
