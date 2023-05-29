class Industry < ApplicationRecord
  has_many :jobs

  scope :top_industries, -> { order(job_count: :desc).limit(9) }

    
end
