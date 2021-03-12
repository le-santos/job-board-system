class OffersController < ApplicationController
  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)

    job_application = JobApplication.find(params[:job_application_id])
    @offer.job_id = job_application.job.id
    @offer.candidate_id = job_application.candidate.id
    @offer.job_application_id = job_application.id

    if @offer.save
      job_application.accepted!
      redirect_to jobs_path(@offer.job_id), notice: t('.success')
    else
      flash.now[:alert] = @offer.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @offer = Offer.find_by(job_application: params[:job_application_id])
  end

  def accept
    @offer = Offer.find_by(job_application: params[:job_application_id])

    if @offer.accept?(offer_params[:confirmation_date])
      redirect_to job_applications_candidate_path(@offer.candidate),
                  notice: t('.accepted')
    else
      render job_applications_candidate_path(@offer.candidate_id),
             alert: 'É necessário confirmar a data de início'
    end
  end

  def decline
    @offer = Offer.find(params[:id])

    if offer_params[:decline_message]
      @offer.decline_message = offer_params[:decline_message]
      @offer.declined!
      redirect_to job_applications_candidate_path(@offer.candidate),
                  notice: t('.declined')
    else
      render job_applications_candidate_path(@offer.candidate_id),
             alert: 'É necessário preencher o motivo da recusa'
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:message, :salary, :start_date,
                                  :job_id, :candidate_id, :job_application_id,
                                  :confirmation_date, :decline_message)
  end
end
