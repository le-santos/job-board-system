class JobApplication < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  validates :candidate, uniqueness: { scope: :job, message: 'já se candidatou para a vaga' }
  validate :profile_cannot_be_blank

  enum status: { pending: 0, accepted: 1, declined: 2 }

  attr_reader :attributes

  private

  def profile_cannot_be_blank
    candidate = Candidate.find(candidate_id) 
    candidate_att = [ candidate.cpf, candidate.phone, candidate.biography, candidate.skills ]

    if candidate_att.any? { |att| att.blank? } 
      errors.add(:candidate, "precisa preecher seu perfil")
    end
  end
end