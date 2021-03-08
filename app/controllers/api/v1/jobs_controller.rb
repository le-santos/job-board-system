module Api
  module V1
    class JobsController < ApiController
      def index
        jobs = Job.all
        render json: jobs
      end
    end
  end
end
