require 'rails_helper'

RSpec.describe Company, type: :model do
  context '#has_empty_profile?' do
    it 'should returns true if any attribute is nil' do
      company = Company.create( domain: 'www.domain.com')

      profile_check = company.has_empty_profile?

      expect(profile_check).to be_truthy
    end

    it 'should returns false if company profile is complete' do
      company = Company.create!(name: 'Atendbots' , 
                              description: 'Sistemas de automação de atendimento (chatbots) para pequenos negócios' , 
                              logo: 'atendbot_url' , 
                              address: 'Rua dos devs, 101, São Paulo, SP', 
                              tech_stack: 'HTML, Ruby, Ruby on Rails, Bootstrap', 
                              domain: 'www.atendbots.com.br')

      profile_check = company.has_empty_profile?

      expect(profile_check).to be_falsey
    end
  end
end
