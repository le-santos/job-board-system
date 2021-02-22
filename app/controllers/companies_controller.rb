class CompaniesController < ApplicationController
  before_action :check_employee_admin, only: [:create, :edit, :update]
  before_action :check_employee_staff, only: [:job_applications]
  # FIXME - cada company deve ter uma coluna indicando quem é admin

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end 

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      redirect_to @company, notice: 'Perfil da empresa foi atualizado'
    else
      render :edit
    end
  end

  def job_applications
    @company = Company.find(params[:id])
    @job_apps = @company.job_applications.to_a
    @job_applications = @company.get_job_applications(@job_apps)
  end

  private

  def company_params
    params.require(:company).permit(:name, 
                                    :description, 
                                    :address, 
                                    :tech_stack, 
                                    :logo)
  end

  def check_employee_admin
    @company = Company.find(params[:id])
  
    unless employee_signed_in? && current_employee.admin? 
      redirect_to company_path(@company), notice: t('.admin_only')
    end
  end

  def check_employee_staff
    @company = Company.find(params[:id])
  
    unless employee_signed_in? && current_employee.company == @company 
      redirect_to company_path(@company)
    end
  end
end
