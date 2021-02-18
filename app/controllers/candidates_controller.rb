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
    current_candidate.applyForJob!(job)
    redirect_to job, notice: 'Candidatura enviada'
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :cpf, :phone, :biography, :skills)
  end
end