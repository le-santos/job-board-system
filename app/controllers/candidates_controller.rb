class CandidatesController < ApplicationController

  before_action :authenticate_candidate!

  def show
    @candidate = Candidate.find(params[:id])
  end

  def edit
    @candidate = Candidate.find(params[:id])
  end

  def update
    @candidate = Candidate.find(params[:id])

    if @candidate.update(candidate_params)
      redirect_to candidate_path(@candidate)
    else
      render :edit
    end
  end

  def apply
    job = Job.find(params[:id])

    begin
      current_candidate.applyForJob!(job)
      redirect_to job, notice: 'Candidatura enviada'

    rescue ActiveRecord::RecordInvalid => exception
      if exception.to_s.include?('perfil')
        redirect_to job_path(job), alert: 'É necessário completar seu perfil'
      else
        redirect_to job_path(job), alert: 'Já existe uma candidatura para essa vaga'
      end
    end
  end

  def job_applications
    @candidate = Candidate.find(params[:id])
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :cpf, :phone, :biography, :skills)
  end
end