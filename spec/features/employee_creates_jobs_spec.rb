require 'rails_helper'

feature 'Employee creates new jobs' do
  scenario 'successfully' do
    employee = FactoryBot.create(:employee )
    company = employee.company

    login_as employee, scope: :employee
    visit company_path(company)
    click_on 'Criar Vagas'
    within('form') do
      fill_in 'Título da Vaga', with: 'Desenvolvedor(a) Backend Júnior'
      fill_in 'Detalhes', with: 'Desenvolvedor(a) Ruby on Rails para desenvolvimento de aplicações web'
      fill_in 'Salário', with: 3500
      fill_in 'Nível', with: 'Júnior'
      fill_in 'Requisitos', with: 'Ruby on Rails, SQLite, HTML, CSS, Bootstrap, Git, TDD'
      fill_in 'Data Limite', with: '24/12/2022'
      fill_in 'Quantidade de Vagas', with: 4
      click_on 'Salvar'
    end
    
    expect(company.jobs.count).to eq(1)
    expect(Job.last.company).to eq(company)
    expect(current_path).to eq(job_path(company.jobs.last))
  end

  scenario 'only if employee is company staff/admin' do
    other_copany_employee = FactoryBot.create(:employee)
    company = FactoryBot.create(:company, { name: 'Empresa 2', domain: 'www.empresa2.com.br'})

    login_as other_copany_employee, scope: :employee
    visit company_path(company)

    expect(page).not_to have_link('Criar Vagas')
  end
  
  scenario 'and can edit details' do
    employee = FactoryBot.create(:employee )
    company = employee.company
    job = FactoryBot.create(:job, { title: 'Desenvolvedor(a) Frontend'} )

    login_as employee, scope: :employee
    visit company_path(company)
    within("div.job-#{job.id}") do
      click_on 'Detalhes da Vaga'
    end
    click_on 'Editar Vaga'
    within('form') do
      fill_in 'Título da Vaga', with: 'Desenvolvedor(a) Fullstack'
      click_on 'Salvar'
    end

    job.reload
    expect(job.title).to eq('Desenvolvedor(a) Fullstack')
    expect(page).to have_content('Vaga atualizada com sucesso')
  end

  scenario 'and can inactivate job' do
    employee = FactoryBot.create(:employee )
    company = employee.company
    job = FactoryBot.create(:job, { title: 'Desenvolvedor(a) Frontend'} )

    login_as employee, scope: :employee
    visit job_path(job)
    click_on 'Desativar Vaga'

    job.reload
    expect(page).to have_content('Vaga desativada!')
    expect(page).not_to have_link('Desativar Vaga')
    expect(job.status).to eq('inactive')
  end
end