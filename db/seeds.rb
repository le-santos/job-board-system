# Sample Data setup

companies = [
  {
    name: 'Atendbots' , 
    description: 'Sistemas de automação de atendimento (chatbots)' , 
    logo: 'atendbot_url' , 
    address: 'Rua dos devs, 101, São Paulo, SP', 
    tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap',
    domain: 'www.atendbots.com.br'
  },
  {
    name: 'SuperWeb' , 
    description: 'Elaboração de sistemas Web' , 
    logo: 'superweb_url' , 
    address: 'Rua dos devs, 101, São Paulo, SP', 
    tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap',
    domain: 'www.superweb.com.br'
  },
  {
    name: 'devapps' , 
    description: 'Aplicativos para negócios' , 
    logo: 'devapps_url' , 
    address: 'Rua dos devs, 101, São Paulo, SP', 
    tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap',
    domain: 'www.devapps.com.br'
  }
]

Company.create(companies)

employees = [ 'paco@atendbots.com.br', 'paula@superweb.com.br', 'pedro@devapps.com.br']

employees.each do |employee|
  Employee.create(email: employee, password: '123456')
end

candidates = ['Teco Sousa', 'Tico Santos', 'Teca Silva']

candidates.each do |candidate|
  Candidate.create(name: candidate, 
                    email: "#{candidate.split.first}@gmail.com",
                    password: '123456', cpf: '123.456.789-00', 
                    phone: '12-123456', biography: 'Dev estudante profissional', 
                    skills: 'Ruby on Rails' )
end

jobs = [
  {
    title: 'Desenvolvedor(a) Backend Júnior', 
    details: 'Desenvolvedor(a) Ruby on Rails para desenvolvimento de aplicações web', 
    salary: 3500, 
    level: 'Júnior', 
    requirements: 'Ruby on Rails, SQLite, HTML, CSS, Bootstrap, Git, TDD', 
    deadline: '24/12/2022', 
    quantity_of_positions: 4, 
    company: Company.first
  }, 
  {
    title: 'Desenvolvedor(a) Frontend Pleno', 
    details: 'Desenvolvedor(a) React para desenvolvimento de aplicações web', 
    salary: 5000, 
    level: 'Pleno', 
    requirements: 'React, Javascript, HTML, CSS', 
    deadline: '24/12/2022', 
    quantity_of_positions: 4, 
    company: Company.last
  }
]

Job.create(jobs)

JobApplication.create(candidate: Candidate.last , job: Job.last, status: 'accepted')
JobApplication.create(candidate: Candidate.first , job: Job.last, status: 'pending')

Offer.create([
              {
                message: "Candidatura aceita! Avalie nossa proposta", 
                salary: 3000, start_date: "31-12-2021", job_id: Job.last.id, 
                candidate_id: Candidate.first.id, job_application: JobApplication.first
              },
              {
                message: "Candidatura aceita! Avalie nossa proposta", 
                salary: 3000, start_date: "31-12-2021", job_id: Job.last.id, 
                candidate_id: Candidate.last.id, job_application: JobApplication.last
              }
            ])

