class City < ApplicationRecord
  has_many :jobs
  scope :topCities, -> { order(job_count: :desc).limit(9) }
end
