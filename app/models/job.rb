class Job < ApplicationRecord
  belongs_to :work_place
  belongs_to :industry
  self.inheritance_column = 'job_type'
  searchable do
    text :name, stored: true
    text :description, stored: true
    text :company_name, stored: true
    text :requirement, stored: true
    text :benefit, stored: true
    string :company_address, stored: true
    string :company_province, stored: true
    string :company_district, stored: true
  end
end
