require 'rails_helper'

feature 'A visitor creates a candidate profile' do
  #TODO usar factory bot para diminuir tamanho dos testes
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
    fill_in 'Nome', with: 'Paco Silva'
    fill_in 'E-mail', with: 'paco@gmail.com'
    fill_in 'Senha',  with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    fill_in 'CPF', with: '123.456.789-00'
    fill_in 'Fone', with: '11 91234-5678'
    fill_in 'Biografia', with: 'Estudante de Ciência da Computação'
    fill_in 'Habilidades', with: 'Ruby on Rails, HTML'
    click_on 'Inscrever-se'
    
    expect(Candidate.last.email).to eq('paco@gmail.com')
    expect(page).to have_content('Você realizou seu registro com sucesso.')
    expect(page).to have_content('paco@gmail.com')
    expect(page).to have_link('Sair')
  end

  scenario 'and email must be unique' do
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
    Candidate.create!(email: 'paco@gmail.com', 
                      password: '123456', 
                      name: 'P', cpf: '123', 
                      phone: '123', biography: 'Bla', 
                      skills: 'bla' )

    visit job_path(job)
    click_on 'Candidatar-se'
    click_on 'Criar conta'
    fill_in 'E-mail', with: 'paco@gmail.com'
    fill_in 'Senha',  with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    fill_in 'CPF', with: '123.456.789-00'
    fill_in 'Fone', with: '11 91234-5678'
    fill_in 'Biografia', with: 'Estudante de Ciência da Computação'
    fill_in 'Habilidades', with: 'Ruby on Rails, HTML'
    click_on 'Inscrever-se'
    
    expect(page).to have_content('E-mail já está em uso')
  end

  scenario 'and attributes must not be blank' do
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

    visit job_path(job)
    click_on 'Candidatar-se'
    click_on 'Criar conta'
    click_on 'Inscrever-se'
    
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Fone não pode ficar em branco')
    expect(page).to have_content('Biografia não pode ficar em branco')
    expect(page).to have_content('Habilidades não pode ficar em branco')
  end
end