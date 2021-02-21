class Company < ApplicationRecord
  has_many :jobs
  has_many :employees
  has_one :employee, -> { where role: :admin }

  validates :domain, presence: true

  def has_empty_profile?
    self.attributes.values.any?(&:blank?)
  end

  def admin
    employees.admin
  end

end
