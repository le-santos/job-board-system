require 'rails_helper'

feature 'A visitor creates a candidate account' do
  scenario 'successfully' do
    company = FactoryBot.create(:company, { name: 'Atendbots' })
    job = FactoryBot.create(:job, company: company)

    visit root_path
    click_on 'Empresas'
    click_on 'Atendbots'
    within("div.job-#{job.id}") do
      click_on 'Detalhes da Vaga'
    end
    click_on 'Candidatar-se'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Paco Silva'
    fill_in 'E-mail', with: 'paco@gmail.com'
    fill_in 'Senha',  with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Inscrever-se'
    
    expect(Candidate.last.email).to eq('paco@gmail.com')
    expect(page).to have_content('Você realizou seu registro com sucesso.')
    expect(page).to have_content('paco@gmail.com')
    expect(page).to have_link('Sair')
  end

  scenario 'and returns to job application page' do
    company = FactoryBot.create(:company, { name: 'Atendbots' })
    job = FactoryBot.create(:job, company: company)

    visit job_path(job)
    click_on 'Candidatar-se'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Paco Silva'
    fill_in 'E-mail', with: 'paco@gmail.com'
    fill_in 'Senha',  with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Inscrever-se'

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content(company.name)
    expect(page).to have_content(job.title)
    expect(page).not_to have_link('Candidatar-se')
    expect(page).to have_link('Enviar Candidatura')
  end

  scenario 'and email must be unique' do
    company = FactoryBot.create(:company, { name: 'Atendbots' })
    job = FactoryBot.create(:job, company: company)
    candidate = FactoryBot.create(:candidate, { email: 'paco@gmail.com' })

    visit job_path(job)
    click_on 'Candidatar-se'
    click_on 'Criar conta'
    fill_in 'E-mail', with: 'paco@gmail.com'
    fill_in 'Senha',  with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Inscrever-se'
    
    expect(page).to have_content('E-mail já está em uso')
  end

  scenario 'and attributes must not be blank' do
    company = FactoryBot.create(:company, { name: 'Atendbots' })
    job = FactoryBot.create(:job, company: company)

    visit job_path(job)
    click_on 'Candidatar-se'
    click_on 'Criar conta'
    click_on 'Inscrever-se'
    
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
  end

  scenario 'and can sign out' do 
    company = FactoryBot.create(:company, { name: 'Atendbots' })
    job = FactoryBot.create(:job, company: company)

    visit job_path(job)
    click_on 'Candidatar-se'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Paco Silva'
    fill_in 'E-mail', with: 'paco@gmail.com'
    fill_in 'Senha',  with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Inscrever-se'
    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Logout efetuado com sucesso.')
  end
end