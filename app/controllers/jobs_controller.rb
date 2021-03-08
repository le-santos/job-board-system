class JobsController < ApplicationController
  before_action :authenticate_employee!, except: %i[index show]

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.company = current_employee.company

    if @job.save
      redirect_to @job, notice: t('.success')
    else
      render new
    end
  end

  def show
    @job = find_job
  end

  def edit
    @job = find_job
  end

  def update
    @job = find_job

    if @job.update(job_params)
      redirect_to @job, notice: 'Vaga atualizada com sucesso'
    else
      render :edit
    end
  end

  def inactivate
    @job = find_job
    @job.inactive!
    redirect_to @job, notice: 'Vaga desativada!'
  end

  private

  def job_params
    params.require(:job).permit(:company_id, :title, :description,
                                :salary, :level, :requirements,
                                :deadline, :quantity_of_positions)
  end

  def find_job
    Job.find(params[:id])
  end
end
