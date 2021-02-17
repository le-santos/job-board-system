require 'rails_helper'

feature 'Candidate' do
  scenario 'views its profile' do
    candidate = Candidate.create!(email: 'paco@gmail.com', 
                                  password: '123456', 
                                  name: 'Paco Silva', cpf: '123', 
                                  phone: '123', biography: 'Bla', 
                                  skills: 'bla' )
    
    visit root_path
    within('header nav') do 
      click_on 'Login para Candidatos'
    end

    within('form') do
      fill_in 'E-mail', with: candidate.email
      fill_in 'Senha', with: candidate.password
      click_on 'Login' 
    end

    within('header nav') do 
      click_on candidate.email
    end
  
    expect(current_path).to eq(candidate_path(candidate))
    expect(page).to have_content('Paco Silva')
  end

  scenario 'edits profile successfully' do
    candidate = Candidate.create!(email: 'paco@gmail.com', 
                                  password: '123456', 
                                  name: 'Paco Silva', cpf: '123', 
                                  phone: '123', biography: 'Bla', 
                                  skills: 'bla' )
    
    visit root_path
    within('header nav') do 
      click_on 'Login para Candidatos'
    end

    within('form') do
      fill_in 'E-mail', with: candidate.email
      fill_in 'Senha', with: candidate.password
      click_on 'Login' 
    end

    within('header nav') do 
      click_on candidate.email
    end
    
    click_on 'Editar Perfil'
    fill_in 'Nome', with: 'Francisco'
    click_on 'Salvar'
  
    expect(current_path).to eq(candidate_path(candidate))
    expect(page).to have_content('Francisco')
    expect(page).not_to have_content('Paco Silva')

  end
end