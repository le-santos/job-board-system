require 'rails_helper'

feature 'Visitor views company available jobs' do
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
      expect(page).to have_content(job.title)
      expect(page).to have_content('Até R$ 3.500')
      expect(page).to have_content(job.level)
    end
  end

  scenario 'and there is no job' do
    company = Company.create!(name: 'Atendbots' , 
                              description: 'Sistemas de automação de atendimento (chatbots) para pequenos negócios' , 
                              logo: 'atendbot_url' , 
                              address: 'Rua dos devs, 101, São Paulo, SP', 
                              tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap', 
                              domain: 'www.atendbots.com.br')

    visit root_path
    click_on 'Empresas'
    click_on 'Atendbots'

    expect(page).to have_content('Nenhuma vaga disponível no momento')
    expect(page).not_to have_css("section.job-list")
  end
end