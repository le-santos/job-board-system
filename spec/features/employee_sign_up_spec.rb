require 'rails_helper'

feature 'An employee sign up' do
  scenario 'successfully' do
  
    visit root_path
    click_on 'Login para Empresas'
    click_on 'Criar conta'
    within('form') do
      fill_in 'E-mail', with: 'jonas@atendbots.com.br'
      fill_in 'Senha',  with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'
    end
    
    expect(Employee.last.email).to eq('jonas@atendbots.com.br')
    expect(page).to have_content('Você realizou seu registro com sucesso.')
    expect(page).to have_content('jonas@atendbots.com.br')
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
    candidate = FactoryBot.create(:employee, { email: 'jonas@atendbots.com.br' })
    login_as candidate, scope: :candidate
    
    visit root_path
    click_on 'Sair'
    
    expect(page).to have_content('Logout efetuado com sucesso')
    expect(current_path).to eq(root_path)
  end


  scenario 'must be linked to a company' do
    company = FactoryBot.create(:company, { domain: 'www.atendbots.com.br' })

    visit root_path
    click_on 'Login para Empresas'
    click_on 'Criar conta'
    within('form') do
      fill_in 'E-mail', with: 'jonas@atendbots.com.br'
      fill_in 'Senha',  with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content('Você realizou seu registro com sucesso.')
    expect(Employee.last.company).to eq(company)
  end

  scenario 'must create company if first employee' do
    

  end

end