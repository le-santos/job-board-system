class Job < ApplicationRecord
  belongs_to :company
  has_many :job_applications
  has_many :candidates, through: :job_applications
  has_many :offers

  validates :company_id, presence: true


  enum status: { active: 0, filled: 1, inactive: 5 }

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
end
