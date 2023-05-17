class Job < ApplicationRecord
  scope :total_jobs_count, -> { count }
  scope :latestJobs, -> { order(created_at: :desc).limit(5) }
  scope :topCities, -> { group(:company_province).order('count_id DESC').limit(9).count(:id) }

  searchable do
    string :company_address, :body
    string :company_province
    string :work_place  
  end

  self.inheritance_column = :type_job

  def self.import_columns
    %i[benefit category company_address company_district company_id company_name company_province
       description level name requirement salary type contact_email contact_name contact_phone work_place]
  end
end
