require 'rails_helper'

feature 'A candidate applies for a job' do
  scenario 'successfully' do
    company = FactoryBot.create(:company, { name: 'Atendbots' })
    job = FactoryBot.create(:job, company: company)

    candidate = Candidate.create!(email: 'paco@gmail.com', 
                                  password: '123456', 
                                  name: 'Paco Silva', cpf: '123456789', 
                                  phone: '123123', biography: 'Estudante', 
                                  skills: 'Ruby on Rails' )

    login_as candidate, scope: :candidate
    visit job_path(job)
    click_on 'Enviar Candidatura'

    expect(JobApplication.last.candidate).to eq(candidate)
    expect(page).to have_content('Candidatura enviada')
  end

  scenario 'and can view their applications' do
    company = FactoryBot.create(:company, { name: 'Atendbots' })
    job = FactoryBot.create(:job, company: company)
    candidate = FactoryBot.create(:candidate)
    application = JobApplication.create(candidate: candidate, job: job)
    
    login_as candidate, scope: :candidate
    visit candidate_path(candidate)

    expect(page).to have_content('Minhas Candidaturas')
    within('div.job-applications') do
      expect(page).to have_content('Empresa: Atendbots')
      expect(page).to have_content('Vaga: Desenvolvedor(a) Backend Júnior')
    end
  end
end