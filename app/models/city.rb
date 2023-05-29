class City < ApplicationRecord
  has_many :jobs
  scope :top_cities, -> { order(job_count: :desc).limit(9) }
end
