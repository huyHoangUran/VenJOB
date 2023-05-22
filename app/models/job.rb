class Job < ApplicationRecord
  belongs_to :city
  belongs_to :industry
  attribute :type_job, :string, default: ''
  searchable do
    integer :id, stored: true
    text  :name, stored: true, boost: 99
    text  :company_name, stored: true, boost: 90
    text  :benefit, stored: true, boost: 85
    text  :company_address, stored: true, boost: 80
    text  :company_district, stored: true, boost: 75
    text  :company_province, stored: true, boost: 70
    text  :requirement, stored: true, boost: 65
    text  :description, stored: true, boost: 60
    text  :industry_name, stored: true, boost: 55 do |p|
      p.industry.name
    end
    text :city_name, stored: true, boost: 50 do |p|
      p.city.name if p.city.present?
    end
  end
end
