require 'rails_helper'

feature 'A visitor creates a profile' do
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

    visit root_path
    click_on 'Empresas'
    click_on 'Atendbots'
    within("div.job-#{job.id}") do
      click_on 'Detalhes da vaga'
    end
    click_on 'Candidatar-se'
    click_on 'Criar conta'
    fill_in 'E-mail', with: 'paco@gmail.com'
    fill_in 'Senha',  with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'
    
    
    expect(Candidate.last).to eq(candidate)
    expect(page).to have_content('Perfil Cadastrado')
    expect(current_path).to eq(company_job_path(job))
  end
end