class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def show
    @patient = Patient.find_by(id: params[:id])
  end

  def new
    @patient = Patient.new()
  end

  
end
