FactoryBot.define do
  factory :employee do
    email { 'jonas@atendbots.com.br' }
    password { '123456' }
    company { Company.last || association(:company) }
  end
end
