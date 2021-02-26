require 'rails_helper'

RSpec.describe Job, type: :model do
  context '#positions_filled?' do
    it 'if true, job status is fulfilled' do
      company = FactoryBot.create(:company)
      job = FactoryBot.create(:job, { quantity_of_positions: 1 })
      candidate = FactoryBot.create(:candidate)
      application = JobApplication.create(candidate: candidate, job: job, status: :accepted)
      offer = FactoryBot.create(:offer, { start_date: '31-12-2021' })

      offer.accept?(confirmation_date: '31-12-2021')

      job.reload
      expect(job.positions_filled?).to be_truthy
      expect(job.status).to eq('filled')
      expect(job.quantity_of_positions).to eq(0)
    end
  end

  xcontext '#job_expired?' do
    it '' do
      
    end
  end

end
