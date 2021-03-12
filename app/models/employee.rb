class Employee < ApplicationRecord
  before_validation :domain_check
  before_validation :search_company

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company

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

  def blocked_domains 
    [ 'msn.com','icloud.com', 'googlemail.com',
      'att.net', 'gmail.com', 'ymail.com',
      'rocketmail.com', 'aol.com', 'yahoo.com', 
      "hotmail.com", 'live.com', 'outlook.com'
    ]
  end

  def domain_check
    employee_domain = email.split('@').last

    if blocked_domains.include?(employee_domain)
      errors.add(:email, 'deve ser um email corporativo')
    end
  end

end
