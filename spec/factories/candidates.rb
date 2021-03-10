FactoryBot.define do
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
