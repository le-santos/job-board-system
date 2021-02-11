require 'rails_helper'

feature 'visitor views companies' do
  scenario 'successfully' do
    # TODO Address poderia ser um JSON
    Company.create!(name: 'Atendbots' , 
                    description: 'Sistemas de automação de atendimento (chatbots) para pequenos negócios' , 
                    logo: 'atendbot_url' , 
                    address: 'Rua dos devs, 101, São Paulo, SP', 
                    tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap', 
                    domain: 'www.atendbots.com.br')
    
    visit root_path
    click_on 'Empresas'
    
    expect(page).to have_content('Empresas cadastradas')
    expect(page).to have_content('Atendbots')
    expect(page).to have_content('Sistemas de automação de atendimento (chatbots) para pequenos negócios')
    expect(page).to have_css("img[src*='atendbot_url']")
  end

  scenario 'and views company details' do
    Company.create!(name: 'Atendbots' , 
                    description: 'Sistemas de automação de atendimento (chatbots) para pequenos negócios' , 
                    logo: 'atendbot_url' , 
                    address: 'Rua dos devs, 101, São Paulo, SP', 
                    tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap',
                    domain: 'www.atendbots.com.br')
    
    visit root_path
    click_on 'Empresas'
    click_on 'Atendbots'
    
    expect(page).to have_content('Atendbots')
    expect(page).to have_content('Sistemas de automação de atendimento (chatbots) para pequenos negócios')
    expect(page).to have_content('HTML - Ruby - Ruby on Rails - Bootstrap')
    expect(page).to have_content('Rua dos devs, 101, São Paulo, SP')
    expect(page).to have_css("img[src*='atendbot_url']")
  end

  scenario 'and returns to companies list' do
    Company.create!(name: 'Atendbots' , 
                    description: 'Sistemas de automação de atendimento (chatbots) para pequenos negócios' , 
                    logo: 'atendbot_url' , 
                    address: 'Rua dos devs, 101, São Paulo, SP', 
                    tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap',
                    domain: 'www.atendbots.com.br')
    
    visit root_path
    click_on 'Empresas'
    click_on 'Atendbots'
    click_on 'Voltar'

    expect(page).to have_content('Empresas cadastradas')
    expect(page).to have_content('Atendbots')
    expect(page).to have_content('Sistemas de automação de atendimento (chatbots) para pequenos negócios')
    expect(current_path).to eq(companies_path)
  end

  scenario 'and returns to home page' do
    Company.create!(name: 'Atendbots' , 
                    description: 'Sistemas de automação de atendimento (chatbots) para pequenos negócios' , 
                    logo: 'atendbot_url' , 
                    address: 'Rua dos devs, 101, São Paulo, SP', 
                    tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap', 
                    domain: 'www.atendbots.com.br')
    
    visit root_path
    click_on 'Empresas'
    click_on 'Atendbots'
    click_on 'Início'

    expect(page).to have_content('Job 4 Devs')
    expect(page).to have_content('Vagas de tecnologia')
    expect(page).to have_link('Empresas')
    expect(page).to have_link('Vagas')
    expect(current_path).to eq(root_path)
  end

  scenario 'and there is no company subscribed' do
    visit root_path
    click_on 'Empresas'

    expect(Company.all.empty?).to be_truthy
    expect(page).to have_content('Nenhuma empresa cadastrada')
  end
end