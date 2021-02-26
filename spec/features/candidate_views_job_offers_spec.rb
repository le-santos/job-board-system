require 'rails_helper'

feature 'Candidate views job offers' do
  scenario 'successfully' do
    company = FactoryBot.create(:company)
    job = FactoryBot.create(:job)
    candidate = FactoryBot.create(:candidate)
    application = JobApplication.create(candidate: candidate, job: job, status: :accepted)
    offer = FactoryBot.create(:offer, { message: 'Candidatura aceita! Avalie nossa proposta'})
    
    login_as candidate, scope: :candidate
    visit root_path
    click_on candidate.email
    click_on 'Minhas Candidaturas'
    within("div.job-app-#{application.id}") do
      click_on 'Ver Proposta'
    end
    
    expect(page).to have_content('Proposta de Emprego')
    expect(page).to have_content('Candidatura aceita! Avalie nossa proposta')
  end
  
  scenario 'and accept job offers' do
    company = FactoryBot.create(:company)
    job = FactoryBot.create(:job)
    candidate = FactoryBot.create(:candidate)
    application = JobApplication.create(candidate: candidate, job: job, status: :accepted)
    offer = FactoryBot.create(:offer)
    
    login_as candidate, scope: :candidate
    visit job_applications_candidate_path(candidate)
    within("div.job-app-#{application.id}") do
      click_on 'Ver Proposta'
    end
    within('form.accept-form') do
      fill_in 'Confirmo data de início em:', with: '31-12-2021'
      click_on 'Aceitar Proposta'
    end

    offer.reload
    expect(offer.accepted?).to be_truthy
    expect(page).to have_content('Minhas Candidaturas')
    expect(page).to have_content('Proposta aceita')
  end

  scenario 'and decline job offers' do
    company = FactoryBot.create(:company)
    job = FactoryBot.create(:job)
    candidate = FactoryBot.create(:candidate)
    application = JobApplication.create(candidate: candidate, job: job, status: :accepted)
    offer = FactoryBot.create(:offer)
    
    login_as candidate, scope: :candidate
    visit job_applications_candidate_path(candidate)
    within("div.job-app-#{application.id}") do
      click_on 'Ver Proposta'
    end
    within('form.decline-form') do
      fill_in 'Motivo da recusa', with: 'Salário incompatível'
      click_on 'Recusar'
    end

    offer.reload
    expect(offer.declined?).to be_truthy
    expect(page).to have_content('Minhas Candidaturas')
    expect(page).to have_content('Proposta recusada')
    expect(offer.decline_message).to eq('Salário incompatível')
  end
end