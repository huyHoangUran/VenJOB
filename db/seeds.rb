# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'jobs.csv'))
csv = CSV.parse(csv_text, headers: true)

jobs = []
csv.each do |row|
  job = Job.new
  job.benefit = row['benefit']
  job.company_address = row['company_address']
  job.company_district = row['company_district']
  job.company_name = row['company_name']
  job.company_province = row['company_province']
  job.description = row['description']
  job.level = row['level']
  job.name = row['name']
  job.requirement = row['requirement']
  job.salary = row['salary']
  job.type = row['type']
  job.contact_email = row['contact_email']
  job.contact_name = row['contact_name']
  job.contact_phone = row['contact_phone']

  industry_name = row['category']
  industry = Industry.find_or_create_by(name: industry_name)
  job.industry = industry

  work_place_name = row['work_place']
  work_place_name = work_place_name.gsub(/[\["\]]/, '') if work_place_name
  work_place = WorkPlace.find_or_create_by(name: work_place_name)
  job.work_place = work_place
  jobs << job
end

Job.import jobs
