class Company < ApplicationRecord
  has_many :jobs
  has_many :employees

  def has_empty_profile?
    self.attributes.values.any?(&:blank?)
  end

end
