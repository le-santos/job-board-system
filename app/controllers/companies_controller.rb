class CompaniesController < ApplicationController
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
end
