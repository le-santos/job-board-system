class JobsController < ApplicationController
  before_action :authenticate_employee!, except: %i[ index show ]

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new()
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
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      redirect_to @job, notice: 'Vaga atualizada com sucesso'
    else
      render :edit
    end
  end

  def inactivate
    @job = Job.find(params[:id])
    
    @job.inactive!
    redirect_to @job, notice: 'Vaga desativada!'
  end

  private
  def job_params
    params.require(:job).permit(:company_id, :title, :description, 
                                :salary, :level, :requirements, 
                                :deadline, :quantity_of_positions)
  end
end
