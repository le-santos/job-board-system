class Job < ApplicationRecord
  belongs_to :company

  has_many :job_applications
  has_many :candidates, through: :job_applications
end
