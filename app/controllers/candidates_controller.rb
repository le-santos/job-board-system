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
    #applyForJob(current_candidate, job)
    
    if JobApplication.create(candidate: self, job: job)      
      redirect_to job, notice: 'Candidatura enviada'
    else
      render job
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :cpf, :phone, :biography, :skills)
  end
end