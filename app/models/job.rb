class Job < ApplicationRecord
  belongs_to :company
  has_many :job_applications
  has_many :candidates, through: :job_applications
  has_many :offers

  validates :company_id, presence: true


  enum status: { active: 0, inactive: 5 }

end
