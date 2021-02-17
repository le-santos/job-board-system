require 'rails_helper'

RSpec.describe Job, type: :model do
  context '#apply' do
    it 'should creates a JobApplication object' do
      candidate = FactoryBot.create(:candidate)
      job = FactoryBot.create(:job)
    
      job_app = job.applyForJob!(candidate)

      expect(candidate.job_applications.size).to eq(1)
      expect(candidate.job_applications.last).to eq(job_app)
    end

    #it 'should not apply if JobApplication already exists' do
    
    #end 
  end
end
