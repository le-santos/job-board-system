require 'rails_helper'

feature 'Employee creates a job offer' do
  scenario 'successfully' do
    company = FactoryBot.create(:company)
    employee = FactoryBot.create(:employee)
    job = FactoryBot.create(:job)
    candidate = FactoryBot.create(:candidate)
    job_application = JobApplication.create(candidate: candidate, job: job)

    
    login_as employee, scope: :employee
    visit root_path
    click_on candidate.email
    click_on 'Candidaturas Recebidas'
    click_on 'Enviar Proposta'
    within('form') do
      fill_in 'Mensagem', with: 'Aceitamos sua candidatura!'
      fill_in 'Proposta Salarial', with: 3000
      fill_in 'Data limite', with: '29/12/2021'
    end

    expect(page).to have_content('Proposta enviada')
    expect(candidate.offers.count).to eq(1)
    expect(job_application.offers.count).to eq(1)
  end
end