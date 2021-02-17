class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def apply
    job = Job.find(params[:id])
    # TODO remover essa criação de instancia do controller
    JobApplication.create!(candidate: current_candidate, job: job)
    redirect_to job, notice: 'Candidatura enviada'
  end
end
