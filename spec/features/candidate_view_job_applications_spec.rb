require 'rails_helper'

feature 'Candidate view their job applications' do
  scenario 'successfully' do
    company = FactoryBot.create(:company, { name: 'Atendbots' })
    job = FactoryBot.create(:job)
    candidate = FactoryBot.create(:candidate)
    application = JobApplication.create(candidate: candidate, job: job)
    
    login_as candidate, scope: :candidate
    visit candidate_path(candidate)
    click_on 'Minhas Candidaturas'

    within('div.job-applications') do
      expect(page).to have_content('Empresa: Atendbots')
      expect(page).to have_content('Vaga: Desenvolvedor(a) Backend Júnior')
    end
  end

  scenario 'and can see job application status' do
    company = FactoryBot.create(:company)
    job = FactoryBot.create(:job)
    candidate = FactoryBot.create(:candidate)
    application = JobApplication.create(candidate: candidate, job: job)
    
    login_as candidate, scope: :candidate
    visit job_applications_candidate_path(candidate)

    expect(page).to have_content('Minhas Candidaturas')
    within("div.job-app-#{application.id}") do
      expect(page).to have_content('Status: Pendente de avaliação')
    end
  end

  scenario 'and can see declined job application messages' do
    company = FactoryBot.create(:company)
    job = FactoryBot.create(:job)
    candidate = FactoryBot.create(:candidate)
    application = JobApplication.create(candidate: candidate, 
                                        job: job,
                                        status: 'declined', 
                                        message: 'Candidato não atende requisitos')
    
    login_as candidate, scope: :candidate
    visit job_applications_candidate_path(candidate)

    expect(page).to have_content('Minhas Candidaturas')
    within("div.job-app-#{application.id}") do
      expect(page).to have_content('Status: Candidatura Recusada')
      expect(page).to have_content('Candidato não atende requisitos')
    end
  end
end