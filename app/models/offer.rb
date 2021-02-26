class Offer < ApplicationRecord
  belongs_to :job
  belongs_to :candidate

  validates :message, :salary, :start_date, presence: true

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
end
