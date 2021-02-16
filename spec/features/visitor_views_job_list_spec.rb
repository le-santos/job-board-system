require 'rails_helper'

feature 'Visitor views list jobs' do
  scenario 'successfully' do
    company = Company.create!(name: 'Atendbots' , 
                              description: 'Sistemas de automação de atendimento (chatbots) para pequenos negócios' , 
                              logo: 'atendbot_url' , 
                              address: 'Rua dos devs, 101, São Paulo, SP', 
                              tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap', 
                              domain: 'www.atendbots.com.br')
                    
    job_back = Job.create!(title: 'Desenvolvedor(a) Backend Júnior', 
                      details: 'Desenvolvedor(a) Ruby on Rails', 
                      salary: 3500, 
                      level: 'Júnior', 
                      requirements: 'Ruby on Rails, SQLite, HTML, CSS, Bootstrap, Git, TDD', 
                      deadline: '24/12/2022', 
                      quantity_of_positions: 4, 
                      company: company )
                      
    job_front = Job.create!(title: 'Desenvolvedor(a) Frontend Júnior', 
                      details: 'Desenvolvedor(a) ReactJS', 
                      salary: 3500, 
                      level: 'Júnior', 
                      requirements: 'ReactJS, Styled Components, Bootstrap', 
                      deadline: '24/12/2022', 
                      quantity_of_positions: 4, 
                      company: company )

    visit root_path
    click_on 'Vagas'

    within('section.job-list') do
      expect(page).to have_content(job_back.title)
      expect(page).to have_content(job_front.title)
    end
  end

  scenario 'and there is no job' do
    
    visit root_path
    click_on 'Vagas'

    expect(page).to have_content('Nenhuma vaga disponível no momento')
    expect(page).not_to have_css("section.job-list")
  end
end