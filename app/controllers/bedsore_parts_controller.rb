class BedsorePartsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check
  
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @patient = Patient.find(params[:patient_id])
    bedsore_part = @patient.bedsore_parts.build()
    bedsore_part.update(params, current_nurse)
    if bedsore_part.save()
      flash[:notice] = '新しく褥瘡部位を登録しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
  end

  def destroy
    @bedsore_part = BedsorePart.find(params[:id])
    if @bedsore_part.destroy()
      redirect_back(fallback_location: root_path)
    end
  end

end