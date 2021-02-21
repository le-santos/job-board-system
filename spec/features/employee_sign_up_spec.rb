require 'rails_helper'

feature 'An employee sign up' do
  scenario 'successfully and is linked to a company' do
    company = FactoryBot.create(:company, { domain: 'www.superbots.com.br' })

    visit root_path
    click_on 'Login para Empresas'
    click_on 'Criar conta'
    within('form') do
      fill_in 'E-mail', with: 'jonas@superbots.com.br'
      fill_in 'Senha',  with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'
    end

    expect(Employee.last.email).to eq('jonas@superbots.com.br')
    expect(Employee.last.company).to eq(company)
    expect(page).to have_content('Você realizou seu registro com sucesso.')
    expect(page).to have_content('jonas@superbots.com.br')
    expect(page).to have_link('Sair')
  end

  scenario 'and email must be unique' do
    FactoryBot.create(:employee, { email: 'jonas@atendbots.com.br' })

    visit root_path
    click_on 'Login para Empresas'
    click_on 'Criar conta'
    within('form') do
      fill_in 'E-mail', with: 'jonas@atendbots.com.br'
      fill_in 'Senha',  with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content('E-mail já está em uso')
  end

  scenario 'and can logout' do
    employee = FactoryBot.create(:employee)
    login_as employee, scope: :employee
    
    visit root_path
    click_on 'Sair'
    
    expect(page).to have_content('Logout efetuado com sucesso')
    expect(current_path).to eq(root_path)
  end

  scenario 'must create company if first employee' do

    visit root_path
    click_on 'Login para Empresas'
    click_on 'Criar conta'
    within('form') do
      fill_in 'E-mail', with: 'jonas@atendbots.com.br'
      fill_in 'Senha',  with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'
    end

    expect(current_path).to eq(edit_company_path(Employee.last.company))
    expect(page).to have_content('Completar perfil da Empresa')
  end

  scenario 'and should edit company details if first employee' do

    visit root_path
    click_on 'Login para Empresas'
    click_on 'Criar conta'
    within('form') do
      fill_in 'E-mail', with: 'jonas@atendbots.com.br'
      fill_in 'Senha',  with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'
    end

    within('form') do
      fill_in 'Nome', with: 'Atendbots'
      fill_in 'Descrição',  with: 'Sistemas de automação de atendimento (chatbots)'
      fill_in 'Endereço',  with: 'Rua dos devs, 101, São Paulo, SP'
      fill_in 'Tecnologias',  with: 'HTML, Ruby, Ruby on Rails, Bootstrap'
      fill_in 'Logo', with: 'atendbot_url'
      click_on 'Salvar'
    end

    expect(current_path).to eq(company_path(Company.last))
    expect(page).to have_content('Perfil da empresa foi atualizado')
  end

end