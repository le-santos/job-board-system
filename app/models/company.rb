class Company < ApplicationRecord
  has_many :jobs
  has_many :employees

  validates :domain, presence: true

  def has_empty_profile?
    self.attributes.values.any?(&:blank?)
  end

end
