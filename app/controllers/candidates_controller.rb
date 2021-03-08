class CandidatesController < ApplicationController
  before_action :authenticate_candidate!

  def show
    @candidate = find_candidate
  end

  def edit
    @candidate = find_candidate
  end

  def update
    @candidate = find_candidate

    if @candidate.update(candidate_params)
      redirect_to candidate_path(@candidate)
    else
      render :edit
    end
  end

  def apply
    job = Job.find(params[:id])

    begin
      current_candidate.apply_for_job!(job)
      redirect_to job, notice: 'Candidatura enviada'
    rescue ActiveRecord::RecordInvalid => e
      if e.to_s.include?('perfil')
        redirect_to job_path(job), alert: 'É necessário completar seu perfil'
      else
        redirect_to job_path(job),
                    alert: 'Já existe uma candidatura para essa vaga'
      end
    end
  end

  def job_applications
    @candidate = find_candidate
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :cpf, :phone, :biography, :skills)
  end

  def find_candidate
    Candidate.find(params[:id])
  end
end
