class Job < ApplicationRecord

  belongs_to :city
  belongs_to :industry
  attribute :type_job, :string, default: ''
  scope :latest_jobs, -> { order(created_at: :desc).limit(5) }

  searchable do
    integer :id, stored: true
    text  :name, stored: true, boost: 99
    text  :company_name, stored: true, boost: 90

    text  :benefit, stored: true, boost: 85
    text  :company_address, stored: true, boost: 80
    text  :company_district, stored: true, boost: 75
    text  :work_place, stored: true, boost: 70
    text  :industry_name, stored: true, boost: 65 do |p|

      p.industry.name
    end
    text :city_name, stored: true, boost: 75 do |p|
      p.city.name if p.city.present?
    end
    text  :benefit, stored: true, boost: 70
    text  :company_district, stored: true, boost: 65
    text  :requirement, stored: true, boost: 55
    text  :description, stored: true, boost: 50
  end

  def short_description
    description.present? ? description[0, 130] : ""
  end
  def short_title
    name.present? ? name[0, 20] : ""
  end
  
end
