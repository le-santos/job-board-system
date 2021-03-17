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

  context 'GET Companies list' do
    it 'should render companies list' do
      10.times do
        FactoryBot.create(:company)
      end
      company = FactoryBot.create(:company, {name: 'Test Company'} )

      get '/api/v1/companies'

      expect(response).to have_http_status(200)
      expect(response.body).to include(Company.first.name)
      expect(response.body).to include(company.name)
    end
  end
end
