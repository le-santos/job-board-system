require 'rails_helper'

RSpec.describe 'Job management', type: :request do
  context 'GET Jobs list' do
    it 'should render jobs list' do
      10.times do
        FactoryBot.create(:job)
      end

      get '/api/v1/jobs'

      expect(response).to have_http_status(200)
      expect(response.body).to include(Job.first.title)
      expect(response.body).to include(Job.last.title)
    end
  end
end
