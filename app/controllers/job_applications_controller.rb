class JobApplicationsController < ApplicationController
  before_action :authenticate_employee!, only: [:edit, :update]

  def edit
    @candidate = Candidate.find(params[:candidate])
    @job = Job.find(params[:job])
    @job_application = JobApplication.find_by(candidate: @candidate, job: @job)
  end

  def update
    @job_application = JobApplication.find(params[:id])
    #FIXME não deveria alterar status no edit form e enviar nos params?
    @job_application.status = :declined

    if @job_application.update(job_app_params)
      redirect_to job_applications_company_path, notice: 'Candidatura Atualizada'
    else
      render :edit
    end
  end

  private

  def job_app_params
    params.require(:job_application).permit(:message, :job, :candidate)
  end
end