class Offer < ApplicationRecord
  belongs_to :job
  belongs_to :candidate

  validates :message, :salary, :start_date, presence: true

  enum status: { pending: 0, accepted: 1, declined: 2 }
end
