FactoryBot.define do
  factory :company do
    name { 'Atendbots' }
    description { 'Sistemas de automação de atendimento (chatbots)' }
    logo { 'atendbot_url' }
    address { 'Rua dos devs, 101, São Paulo, SP' }
    tech_stack { 'HTML, Ruby, Ruby on Rails, Bootstrap' }
    domain { 'www.atendbots.com.br' }
  end
end
