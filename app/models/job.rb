class Job < ApplicationRecord
  belongs_to :work_place
  belongs_to :industry
  searchable do
    text :name, stored: true
    text :description, stored: true
    text :company_name, stored: true
    text :requirement, stored: true
    text :benefit, stored: true
    text :company_address, stored: true
    text :company_province, stored: true
    text :company_district, stored: true
    # integer :industry_id, stored: true
    # integer :city_code, stored: true
  end
end
