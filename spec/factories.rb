FactoryBot.define do
  factory :offer do
    message { "Candidatura aceita! Avalie nossa proposta" }
    salary { 3000 }
    start_date { "31-12-2021" }
    job_id { Job.last.id || association(:job) }
    candidate_id { Candidate.last.id || association(:candidate) }
    job_application { JobApplication.last }
  end

  factory :employee do
    email { 'jonas@atendbots.com.br' }
    password { '123456' }
    company { Company.last || association(:company)}
  end

  factory :company do
    name { 'Atendbots' } 
    description { 'Sistemas de automação de atendimento (chatbots)' }
    logo { 'atendbot_url' }
    address { 'Rua dos devs, 101, São Paulo, SP' }
    tech_stack { 'HTML, Ruby, Ruby on Rails, Bootstrap' }
    domain { 'www.atendbots.com.br'  }
  end

  factory :job do
    title { 'Desenvolvedor(a) Backend Júnior' }
    details { 'Desenvolvedor(a) Ruby on Rails para desenvolvimento de aplicações web' }
    salary { 3500 } 
    level { 'Júnior' }
    requirements { 'Ruby on Rails, SQLite, HTML, CSS, Bootstrap, Git, TDD' }
    deadline { '24/12/2022' }
    quantity_of_positions { 4 }
    company { Company.last || association(:company)}
    status { 'active' }
  end
  
  factory :candidate do
    email { 'paco@gmail.com' }
    password { '123456' }
    name { 'Paco Silva' } 
    cpf { '123456789' } 
    phone { '123123' }
    biography { 'Estudante' }
    skills { 'Ruby on Rails' }
  end
end