module Api
  module V1
    class CompaniesController < ApiController
      def index
        companies = Company.all
        render json: companies
      end
    end
  end
end
