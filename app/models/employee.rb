class Employee < ApplicationRecord
  before_validation :search_company

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company
  #FIXME employee não pode mudar seu role de stafdf para admin
  enum role: { staff: 0, admin: 10}

  private
  
  def search_company
    company_domain = email.gsub(/[\S]*@/, 'www.')
    company = Company.find_by(domain: company_domain)
    
    if company.nil?
      # Create company
      self.role = :admin
      company = Company.create(domain: company_domain)
    end
    self.company = company
  end
end
