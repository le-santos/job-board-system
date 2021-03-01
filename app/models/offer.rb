class Offer < ApplicationRecord
  belongs_to :job_application
  has_one :job, through: :job_application
  has_one :candidate, through: :job_application

  validates :message, :salary, :start_date, presence: true
  validate :job_must_be_active

  enum status: { pending: 0, accepted: 1, declined: 2 }

  def accept?(confirmation_date)
    if confirmation_date = self.start_date
      self.accepted!
      self.job.update_quantity_of_positions  
      true
    else
      false
    end
  end

  private
  
  def job_must_be_active
    job = Job.find(job_id)
    unless job.active?
      errors.add(:job, "não está mais aberta")
    end
  end
end
