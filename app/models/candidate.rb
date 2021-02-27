class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true
  has_many :job_applications
  has_many :offers

  def apply_for_job!(job)
    JobApplication.create!(candidate: self, job: job)      
  end

  def has_applied_for?(this_job)
    self.job_applications.any? {|j| j.job == this_job }
  end
end
