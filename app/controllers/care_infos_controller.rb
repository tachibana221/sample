class CareInfosController < ApplicationController
  def index
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
  end

  def show
    care_info_id = params[:id]
    @care_info = CareInfo.find(care_info_id) 
  end

  def edit
    care_info_id = params[:id]
    @care_info = CareInfo.find(care_info_id)  
  end

  def new
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)  
  end

  def create
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
    care_info = @bedsore_part.care_infos.build()
    care_info.update(params, current_nurse)
    if care_info.save()
      flash[:notice] = '新しくケア情報を登録しました'
      redirect_to :action => "index", :bedsore_part_id => bedsore_part_id
    end
  end

  def destroy
    @careinfo = CareInfo.find(params[:id])
    if @careinfo.destroy()
      redirect_back(fallback_location: root_path)
    end
  end
end
