class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  #TODO essa rota apply e action deveria estar dentro de Candidates
  def apply
    job = Job.find(params[:id])
    job.applyForJob!(current_candidate)
    redirect_to job, notice: 'Candidatura enviada'
  end
end
