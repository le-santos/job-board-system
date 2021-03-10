FactoryBot.define do
  factory :job do
    title { 'Desenvolvedor(a) Backend Júnior' }
    details do
      'Desenvolvedor(a) Ruby on Rails para desenvolvimento de aplicações web'
    end
    salary { 3500 }
    level { 'Júnior' }
    requirements { 'Ruby on Rails, SQLite, HTML, CSS, Bootstrap, Git, TDD' }
    deadline { '24/12/2022' }
    quantity_of_positions { 4 }
    company { Company.last || association(:company) }
    status { 'active' }
  end
end
