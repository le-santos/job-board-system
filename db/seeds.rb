require 'faker'

# CANDIDATES SETUP
def candidate_attributes(email: Faker::Internet.free_email,
                         password: Faker::Internet.password)
  name = Faker::Name.first_name
  cpf = Faker::IDNumber.valid
  phone = Faker::PhoneNumber.cell_phone 
  biography = 'Dev estudante profissional'
  skills = 'Ruby on Rails, HTML, CSS, React'

  {name: name, email: email, password: password, cpf: cpf,
   phone: phone, biography: biography, skills: skills}
end

5.times do
  Candidate.create(candidate_attributes)
end

# COMPANIES + EMPLOYEE ADMIN SETUP
def company_attributes(domain: Faker::Internet.domain_name)
  name = Faker::Company.name
  description = Faker::Company.catch_phrase
  logo = Faker::Company.logo
  address = Faker::Address.full_address
  tech_stack = 'Ruby on Rails, React'

  {name: name, description: description, logo: logo,
   address: address, tech_stack: tech_stack, domain: domain}
end

5.times do
  domain = Faker::Internet.domain_name
  admin = Faker::Name.first_name
  Company.create(company_attributes(domain: "www.#{domain}"))
  
  # Admin
  Employee.create(email: "#{admin}@#{domain}", password: '123456', role: 'admin')
end

# Sample users and jobs for Application test

sample_domain = 'devapps.com.br'
admin_employee = 'Paula'
staff_employee = 'Jonas'

sample_company = Company.create(company_attributes(domain: "www.#{sample_domain}"))
Employee.create(email: "#{admin_employee}@#{sample_domain}", password: '123456', role: :admin)
Employee.create(email: "#{staff_employee}@#{sample_domain}", password: '123456')

candidate1 = Candidate.create(
  candidate_attributes(email: 'teca@gmail.com,br', password: '123456'))

#JOBS SETUP

jobs = [
  {
    title: 'Desenvolvedor(a) Backend Júnior', 
    details: 'Desenvolvedor(a) para desenvolvimento de aplicações web', 
    salary: 3500, 
    level: 'Júnior', 
    requirements: 'Ruby on Rails, SQLite, HTML, CSS, Bootstrap, Git, TDD', 
    deadline: '24/12/2022', 
    quantity_of_positions: 4, 
    company: sample_company
  }, 
  {
    title: 'Desenvolvedor(a) Frontend Pleno', 
    details: 'Desenvolvedor(a) React para desenvolvimento de aplicações web', 
    salary: 5000, 
    level: 'Pleno', 
    requirements: 'React, Javascript, HTML, CSS', 
    deadline: '24/12/2022', 
    quantity_of_positions: 4, 
    company: Company.first
  },
  {
    title: 'Desenvolvedor(a) Backend Senior', 
    details: 'Desenvolvedor(a) para desenvolvimento de aplicações web', 
    salary: 7500, 
    level: 'Júnior', 
    requirements: 'Ruby on Rails, SQLite, HTML, CSS, Bootstrap, Git, TDD', 
    deadline: '24/12/2022', 
    quantity_of_positions: 4, 
    company: sample_company
  }
]

Job.create(jobs)

JobApplication.create(candidate: candidate1 , job: Job.first, status: 'accepted')
JobApplication.create(candidate: candidate1 , job: Job.all[1], status: 'pending')

Offer.create([
              {
                message: "Candidatura aceita! Avalie nossa proposta", 
                salary: 3000, start_date: "31-12-2021", job_id: Job.first.id, 
                candidate_id: candidate1.id, job_application: JobApplication.first
              }
            ])