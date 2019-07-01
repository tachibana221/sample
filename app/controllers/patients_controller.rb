class PatientsController < ApplicationController
  def index
    @patients = Patient.all()
  end

  def show
    @patient = Patient.find_by(id: params[:id])
  end

  def new
    @patient = Patient.new()
  end

  def edit
    @patient = Patient.find_by(id: params[:id])
  end

  def create
    @patient = Patient.new()
    @patient.name = params[:name]
    @patient.name_kana = params[:name_kana]
    @patient.age = params[:age]
    @patient.sex = params[:sex]
    if @patient.save()
      flash[:notice] = "新しく療養者を登録しました"
      redirect_to("/patients")
    else
      render("patients/new")
    end
  end

  def update
    @patient = Patient.find_by(id: params[:id])
    @patient.name = params[:name]
    @patient.name_kana = params[:name_kana]
    @patient.age = params[:age]
    @patient.sex = params[:sex]
    if @patient.save()
      flash[:notice] = "登録情報を更新しました"
      redirect_to("/patients")
    else
      render("patients/edit")
    end
  end


end
