class OffersController < ApplicationController
  def new
    @offer = Offer.new()
  end

  def create
    @offer = Offer.new(offer_params)
    
    job_application = JobApplication.find(params[:job_application_id])
    @offer.job = job_application.job
    @offer.candidate = job_application.candidate
    
    if @offer.save
      job_application.accepted!
      redirect_to jobs_path(@offer.job), notice: t('.success')
    else
      #FIXME pq flash nao foi automatico nesse render :new?
      flash.now[:alert] = @offer.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    params
    @offer = Offer.find(params[:id])
  end

  def accept
    @offer = Offer.find(params[:id])
    
    if offer_params[:confirmation_date]
      @offer.accepted!
      redirect_to job_applications_candidate_path(@offer.candidate), notice: t('.accepted')
    else
      render job_applications_candidate_path(@offer.candidate_id), alert: 'É necessário confirmar a data de início'
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:message, :salary, :start_date, :job_id, :candidate_id, :confirmation_date)
  end
end
