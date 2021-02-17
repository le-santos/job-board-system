require 'rails_helper'

feature 'A candidate applies for a job' do
  scenario 'successfully' do
    company = Company.create!(name: 'Atendbots' , 
                              description: 'Sistemas de automação de atendimento (chatbots) para pequenos negócios' , 
                              logo: 'atendbot_url' , 
                              address: 'Rua dos devs, 101, São Paulo, SP', 
                              tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap', 
                              domain: 'www.atendbots.com.br')
                    
    job = Job.create!(title: 'Desenvolvedor(a) Backend Júnior', 
                      details: 'Desenvolvedor(a) Ruby on Rails para desenvolvimento de aplicações web', 
                      salary: 3500, 
                      level: 'Júnior', 
                      requirements: 'Ruby on Rails, SQLite, HTML, CSS, Bootstrap, Git, TDD', 
                      deadline: '24/12/2022', 
                      quantity_of_positions: 4, 
                      company: company )
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
    company = Company.create!(name: 'Atendbots' , 
                              description: 'Sistemas de automação de atendimento (chatbots) para pequenos negócios' , 
                              logo: 'atendbot_url' , 
                              address: 'Rua dos devs, 101, São Paulo, SP', 
                              tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap', 
                              domain: 'www.atendbots.com.br')
                    
    job = Job.create!(title: 'Desenvolvedor(a) Backend Júnior', 
                      details: 'Desenvolvedor(a) Ruby on Rails para desenvolvimento de aplicações web', 
                      salary: 3500, 
                      level: 'Júnior', 
                      requirements: 'Ruby on Rails, SQLite, HTML, CSS, Bootstrap, Git, TDD', 
                      deadline: '24/12/2022', 
                      quantity_of_positions: 4, 
                      company: company )
    candidate = Candidate.create!(email: 'paco@gmail.com', 
                                  password: '123456', 
                                  name: 'Paco Silva', cpf: '123456789', 
                                  phone: '123123', biography: 'Estudante', 
                                  skills: 'Ruby on Rails' )
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