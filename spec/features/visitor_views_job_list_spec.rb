require 'rails_helper'

feature 'Visitor views list jobs' do
  scenario 'successfully' do
    employee = FactoryBot.create(:company )
    job_front = FactoryBot.create(:job, { title: 'Desenvolvedor(a) Frontend'} )
    job_back = FactoryBot.create(:job, { title: 'Desenvolvedor(a) Backend'} )
    
    visit root_path
    click_on 'Vagas'

    expect(page).to have_content(job_back.title)

    within('section.job-list') do
      expect(page).to have_content(job_back.title)
      expect(page).to have_content(job_front.title)
    end
  end

  scenario 'and there is no job' do
    
    visit root_path
    click_on 'Vagas'

    expect(page).to have_content('Nenhuma vaga disponível no momento')
    expect(page).not_to have_css("div.job-details")
  end

  scenario 'and can access job details page' do
    employee = FactoryBot.create(:company )
    job_front = FactoryBot.create(:job, { title: 'Desenvolvedor(a) Frontend'} )
    job_back = FactoryBot.create(:job, { title: 'Desenvolvedor(a) Backend'} )
    
    visit root_path
    click_on 'Vagas'
    within("div.job-details-#{job_front.id}") do
      click_on "Detalhes da Vaga"
    end

    expect(current_path).to eq(job_path(job_front))
    expect(page).to have_content(job_front.title)
  end
end