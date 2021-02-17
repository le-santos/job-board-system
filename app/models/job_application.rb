class JobApplication < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  validates :candidate, uniqueness: { scope: :job, message: 'já se candidatou para a vaga' }
end
