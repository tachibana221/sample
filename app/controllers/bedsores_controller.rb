class BedsoresController < ApplicationController
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

  def create
    bedsore_part_id = params[:bedsore_part_id]
    @bedsore_part = BedsorePart.find(bedsore_part_id)
    bedsore = @bedsore_part.bedsores.build()
    bedsore.update(params, current_nurse)
    if bedsore.save()
      flash[:notice] = '新しく褥瘡情報をを登録しました'
      redirect_to :action => "index", :bedsore_part_id => bedsore_part_id
    end
  end

  def update
    @bedsore = Bedsore.find(params[:id])
    @bedsore.update(params[:bedsore], current_nurse)
    if @bedsore.save()
      flash[:notice] = '褥瘡情報を更新しました'
      redirect_to :action => "index", :bedsore_part_id => @bedsore.bedsore_part.id
    end
  end

  def destroy
    @bedsore = Bedsore.find(params[:id])
    if @bedsore.destroy()
      redirect_back(fallback_location: root_path)
    end
  end
end
