# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'
require 'activerecord-import'

def normalize_city_name(city_name)
  case city_name
  when 'Bắc Cạn'
    'Bắc Kạn'
  when 'Xã Xuân Giao'
    'Lào Cai'
  when 'Thừa Thiên Huế'
    'Thừa Thiên - Huế'
  else
    city_name.gsub(/[\["\]]/, '')
  end
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'jobs.csv'))
csv = CSV.parse(csv_text, headers: true)

job_counts_by_city = Hash.new(0)
work_places = {}
industries = {}
jobs = []

csv.each do |row|
  city_name = normalize_city_name(row['work_place'])
  industry_name = row['category']

  city_name = normalize_city_name(city_name)
  industry_name = industry_name.gsub(/[\["\]]/, '') if industry_name

  job_counts_by_city[city_name] += 1

  work_place = work_places[city_name] || City.find_or_create_by!(name: city_name)
  work_places[city_name] = work_place

  industry = industries[industry_name] || Industry.find_or_create_by!(name: industry_name)
  industries[industry_name] = industry

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
  job.type_job = row['type']
  job.contact_email = row['contact_email']
  job.contact_name = row['contact_name']
  job.contact_phone = row['contact_phone']

  job.city_id = work_place.id
  job.industry_id = industry.id

  jobs << job
end

Job.import jobs
Job.reindex
City.transaction do
  job_counts_by_city.each do |city_name, job_count|
    city = City.find_or_create_by(name: city_name)
    city.update(job_count:)
  end
end

# Job.delete_all
# Industry.delete_all
# WorkPlace.delete_all
