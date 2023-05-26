class Industry < ApplicationRecord
    has_many :jobs

  scope :topIndustries, -> { order(job_count: :desc).limit(9) }

    
end
