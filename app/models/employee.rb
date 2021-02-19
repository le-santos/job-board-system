class Employee < ApplicationRecord
  before_save :search_company

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company, optional: true

  private
  def search_company
    company_domain = email.gsub(/[\S]*@/, 'www.')
    company = Company.find_by(domain: company_domain)
    if company.nil?
      # Create company
    else
      self.company = company
    end
  end
end
