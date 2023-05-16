# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'jobs.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
csv.each do |row|
  t = Job.new
  t.benefit = row['benefit']
  t.category = row['category']
  t.company_address = row['company_address']
  t.company_district = row['company_district']
  t.company_id = row['company_id']
  t.company_name = row['company_name']
  t.company_province = row['company_province']
  t.description = row['description']
  t.level = row['level']
  t.name = row['name']
  t.requirement = row['requirement']
  t.salary = row['salary']
  t.type = row['type']
  t.contact_email = row['contact_email']
  t.contact_name = row['contact_name']
  t.contact_phone = row['contact_phone']
  t.work_place = row['work_place']
  t.save
  #   puts "#{t.street}, #{t.city} saved"
end
