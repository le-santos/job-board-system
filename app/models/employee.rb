class Employee < ApplicationRecord
  before_validation :search_company

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #belongs_to :company, optional: true
  belongs_to :company

  private
  
  def search_company
    company_domain = email.gsub(/[\S]*@/, 'www.')
    company = Company.find_by(domain: company_domain)
    
    if company.nil?
      # Create company
      company = Company.create(domain: company_domain)
      #Add action no controller para criar a company e redirecionar para edit_company
    end
    
    self.company = company
    
  end
end
