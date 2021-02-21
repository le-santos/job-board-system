class CompaniesController < ApplicationController
  before_action :check_employee_admin, only: [:create, :edit, :update]
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
end
