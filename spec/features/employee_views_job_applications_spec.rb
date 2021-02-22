require 'rails_helper'

feature 'Employee views job applications' do
  scenario 'sucessfully' do
    employee = FactoryBot.create(:employee )
    company = employee.company
    job = FactoryBot.create(:job )
    candidate = FactoryBot.create(:candidate)
    job_application = JobApplication.create(candidate: candidate, job: job)

    login_as employee, scope: :employee
    visit company_path(company)
    click_on 'Candidaturas Recebidas'

    expect(page).to have_content('Candidaturas')
    expect(page).to have_content(job.title)
    expect(page).to have_content(candidate.name)
    expect(page).to have_content(candidate.email)
  end

  scenario 'only from their company' do
    employee = FactoryBot.create(:employee )
    company = employee.company
    other_company = FactoryBot.create(:company)
    
    login_as employee, scope: :employee
    visit job_applications_company_path(other_company)

    expect(current_path).to eq(company_path(other_company))
  end


  scenario 'and there are no job applications' do
    employee = FactoryBot.create(:employee )
    company = employee.company
    job = FactoryBot.create(:job )

    login_as employee, scope: :employee
    visit company_path(company)
    click_on 'Candidaturas Recebidas'

    expect(page).to have_content('Nenhuma candidatura recebida')
  end

  scenario 'and can decline application' do
    employee = FactoryBot.create(:employee )
    company = employee.company
    candidate = FactoryBot.create(:candidate)
    job = FactoryBot.create(:job )
    job_application = JobApplication.create(candidate: candidate, job: job)

    login_as employee, scope: :employee
    visit company_path(company)
    click_on 'Candidaturas Recebidas'
    click_on 'Recusar Candidatura'
    within('form') do
      fill_in 'Mensagem', with: 'Candidato não atende requisitos'
      click_on 'Enviar'
    end

    job_application.reload
    expect(current_path).to eq(job_applications_company_path(company))
    expect(page).to have_content('Candidatura Recusada')
    expect(page).to have_content('Candidato não atende requisitos')
  end
end