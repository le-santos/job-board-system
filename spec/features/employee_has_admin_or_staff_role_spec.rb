require 'rails_helper'

feature 'Employee role' do
  scenario 'is :staff if a company already exists at sign up' do
    company = FactoryBot.create(:company)

    visit root_path
    click_on 'Login para Empresas'
    click_on 'Criar conta'
    within('form') do
      fill_in 'E-mail', with: 'jonas@atendbots.com.br'
      fill_in 'Senha',  with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'
    end

    expect(Employee.last.role).to eq('staff')
    expect(Employee.last.company).to eq(company)
    expect(page).to have_content('Você realizou seu registro com sucesso.')
  end

  scenario 'is :admin if employee is the 1st company member to sign up' do

    visit root_path
    click_on 'Login para Empresas'
    click_on 'Criar conta'
    within('form') do
      fill_in 'E-mail', with: 'jonas@atendbots.com.br'
      fill_in 'Senha',  with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'
    end

    expect(Employee.last.role).to eq('admin')
    expect(current_path).to eq(edit_company_path(Employee.last.company))
    expect(page).to have_content('Completar perfil da Empresa')
  end

  scenario 'as :staff cannot edit company profile' do
    company = FactoryBot.create(:company)
    employee = FactoryBot.create(:employee)

    login_as employee, scope: :employee
    visit company_path(company)

    expect(employee.role).to eq('staff')
    expect(current_path).to eq(company_path(employee.company))
    expect(page).not_to have_link('Editar perfil da Empresa')
  end

  scenario 'as :admin can edit company profile' do
    company = FactoryBot.create(:company)
    employee = FactoryBot.create(:employee, { role: :admin } )

    login_as employee, scope: :employee
    visit company_path(company)
    click_on 'Editar perfil da Empresa'
    within('form') do
      fill_in 'Nome', with: 'SuperBots Atendimento'
      click_on 'Salvar'
    end
    
    company.reload
    expect(employee.role).to eq('admin')
    expect(current_path).to eq(company_path(employee.company))
    expect(company.name).to eq('SuperBots Atendimento') 
  end

  scenario 'as :staff cannot access company edit routes' do
    company = FactoryBot.create(:company)
    employee = FactoryBot.create(:employee)

    login_as employee, scope: :employee
    visit edit_company_path(company)

    expect(current_path).to eq(company_path(employee.company))
    expect(page).to have_content('Acesso apenas para Admin')
    expect(employee.role).to eq('staff')
    expect(page).not_to have_link('Editar perfil da Empresa')
  end
end