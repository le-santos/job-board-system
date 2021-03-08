class CompaniesController < ApplicationController
  before_action :check_employee_admin, only: %i[create edit update]
  before_action :check_employee_staff, only: [:job_applications]
  # FIXME: cada company deve ter uma coluna indicando quem é admin

  def index
    @companies = Company.all
  end

  def show
    @company = find_company
  end

  def edit
    @company = find_company
  end

  def update
    @company = find_company

    if @company.update(company_params)
      redirect_to @company, notice: 'Perfil da empresa foi atualizado'
    else
      render :edit
    end
  end

  def job_applications
    @company = find_company
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
    @company = find_company

    return if employee_signed_in? && current_employee.admin?

    redirect_to company_path(@company), notice: t('.admin_only')
  end

  def check_employee_staff
    @company = find_company

    return if employee_signed_in? && current_employee.company == @company

    redirect_to company_path(@company)
  end

  def find_company
    Company.find(params[:id])
  end
end
