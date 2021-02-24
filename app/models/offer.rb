class Offer < ApplicationRecord
  belongs_to :job
  belongs_to :candidate

  validates :message, :salary, :start_date, presence: true

end
