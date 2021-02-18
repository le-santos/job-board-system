require 'rails_helper'

RSpec.describe Candidate, type: :model do
  context '#apply' do
    it 'should creates a JobApplication object' do
      candidate = FactoryBot.create(:candidate)
      job = FactoryBot.create(:job)
    
      job_app = candidate.applyForJob!(job)


      expect(candidate.job_applications.size).to eq(1)
      expect(candidate.job_applications.last).to eq(job_app)
    end

    it 'can not apply if JobApplication already exists' do
      candidate = FactoryBot.create(:candidate)
      job = FactoryBot.create(:job)
      JobApplication.create!(candidate: candidate, job: job)
      
      expect {
        candidate.applyForJob!(job)
      }.to raise_error(ActiveRecord::RecordInvalid)
      
      expect(candidate.job_applications.size).to eq(1)
    end 
  end
end
