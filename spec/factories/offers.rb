FactoryBot.define do
  factory :offer do
    message { 'Candidatura aceita! Avalie nossa proposta' }
    salary { 3000 }
    start_date { '31-12-2021' }
    job_id { Job.last.id || association(:job) }
    candidate_id { Candidate.last.id || association(:candidate) }
    job_application { JobApplication.last }
  end
end
