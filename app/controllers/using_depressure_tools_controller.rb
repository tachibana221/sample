class UsingDepressureToolsController < ApplicationController
  def index; end

  def show
    @using_depressure_tool = UsingDepressureTool.find(params[:id])
    @depressure_tools = DepressureTool.all()
  end

  def edit
    @using_depressure_tool = UsingDepressureTool.find(params[:id])
    @depressure_tools = DepressureTool.all()
  end

  def update
    @using_depressure_tool = UsingDepressureTool.find(params[:id])
    @using_depressure_tool.update(params[:using_depressure_tool])
    if @using_depressure_tool.save()
      flash[:primary] = '登録情報を更新しました'
      redirect_to("/using_depressure_tools/#{params[:id]}")
    else
      @depressure_tools = CareTool.all()
      render('using_depressure_tools/edit')
    end
  end
end
