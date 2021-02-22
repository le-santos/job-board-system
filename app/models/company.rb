class Company < ApplicationRecord
  has_many :jobs
  has_many :employees
  has_one :employee, -> { where role: :admin }
  has_many :job_applications, through: :jobs

  validates :domain, presence: true

  def has_empty_profile?
    self.attributes.values.any?(&:blank?)
  end

  def admin
    employees.admin
  end

  def get_job_applications(job_applications)
    job_applications.map { |j| 
      { candidate: Candidate.find(j.candidate_id),
        job: Job.find(j.job_id) }}
  end

end
