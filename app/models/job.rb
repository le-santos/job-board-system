class Job < ApplicationRecord
  belongs_to :company
  has_many :job_applications
  has_many :candidates, through: :job_applications
  has_many :offers

  validates :company_id, presence: true

  enum status: { active: 0, filled: 1, expired: 3, inactive: 5 }

  after_find :check_if_job_deadline_expired

  def positions_filled?
    self.quantity_of_positions == 0
  end

  def update_quantity_of_positions
    self.quantity_of_positions -= self.offers.accepted.count
    update_status
    save
  end

  private

  def update_status
    if positions_filled?
      self.filled!
    end 
  end

  def check_if_job_deadline_expired
    if Date.parse(deadline) < Date.today
      self.expired!
    end
  end
end
