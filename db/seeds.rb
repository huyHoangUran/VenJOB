require 'csv'
require 'activerecord-import'

Job.delete_all
Industry.delete_all
City.delete_all

ActiveRecord::Base.connection.execute('TRUNCATE TABLE jobs;')
ActiveRecord::Base.connection.execute('TRUNCATE TABLE cities;')
ActiveRecord::Base.connection.execute('TRUNCATE TABLE industries;')

def normalize_city_name(city_name)
  city_mappings = {
    'Bắc Cạn' => 'Bắc Kạn',
    'Xã Xuân Giao' => 'Lào Cai',
    'Thừa Thiên Huế' => 'Thừa Thiên - Huế'
  }
  city_mappings[city_name] || city_name&.gsub(/[\["\]]/, '')
end

vietnam_cities = ['Hà Nội', 'Hồ Chí Minh', 'Đà Nẵng', 'Hải Phòng', 'Cần Thơ', 'Bắc Giang', 'Bắc Kạn', 'Bạc Liêu', 'Bắc Ninh', 'Bến Tre', 'Bình Định', 'Bình Dương', 'Bình Phước', 'Bình Thuận', 'Cà Mau', 'Cao Bằng', 'Đắk Lắk', 'Đắk Nông', 'Điện Biên', 'Đồng Nai', 'Đồng Tháp', 'Gia Lai', 'Hà Giang', 'Hà Nam', 'Hà Tĩnh', 'Hải Dương', 'Hậu Giang', 'Hòa Bình', 'Hưng Yên', 'Khánh Hòa', 'Kiên Giang', 'Kon Tum', 'Lai Châu', 'Lâm Đồng', 'Lạng Sơn', 'Lào Cai', 'Long An', 'Nam Định', 'Nghệ An', 'Ninh Bình', 'Ninh Thuận', 'Phú Thọ', 'Quảng Bình', 'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị', 'Sóc Trăng', 'Sơn La', 'Tây Ninh', 'Thái Bình', 'Thái Nguyên', 'Thanh Hóa', 'Thừa Thiên - Huế', 'Tiền Giang', 'Trà Vinh', 'Tuyên Quang', 'Vĩnh Long', 'Vĩnh Phúc', 'Yên Bái']

# Lưu những thành phố chưa tồn tại trong bảng cities
new_cities = []
vietnam_cities.each do |city_name|
  city = City.find_by(name: city_name)
  new_cities << City.new(name: city_name) unless city
end
City.import new_cities

csv_text = File.read(Rails.root.join('lib', 'seeds', 'jobs.csv'))
csv = CSV.parse(csv_text, headers: true)

industry_names = csv.map { |row| row['category'].to_s.gsub(/[\["\]]/, '').strip }.uniq

industries = industry_names.map { |industry_name| Industry.new(name: industry_name) }
Industry.import industries

city_names = csv.map { |row| normalize_city_name(row['company_province']) }.uniq

# Lưu những thành phố chưa tồn tại trong bảng cities
new_cities = []
city_names.each do |city_name|
  city = City.find_by(name: city_name)
  new_cities << City.new(name: city_name) unless city
end
City.import new_cities

city_map = City.where(name: city_names).index_by(&:name)

jobs = csv.map do |row|
  industry_name = row['category']
  city_name = normalize_city_name(row['company_province'])
  industry_name = industry_name.gsub(/[\["\]]/, '') if industry_name

  city = city_map[city_name]
  industry = Industry.find_by(name: industry_name)

  if city.present? && city_name != 'Khác'
    city.job_count ||= 0
    city.job_count += 1
  end

  if industry.present?
    industry.job_count ||= 0
    industry.job_count += 1
  end

  job = Job.new(
    benefit: row['benefit'],
    company_address: row['company_address'],
    company_district: row['company_district'],
    company_name: row['company_name'],
    description: row['description'],
    level: row['level'],
    name: row['name'],
    requirement: row['requirement'],
    salary: row['salary'],
    type_job: row['type'],
    contact_email: row['contact_email'],
    contact_name: row['contact_name'],
    contact_phone: row['contact_phone'],
    work_place: row['work_place'],
  )

  job.city_id = city.id if city.present?
  job.industry_id = industry.id if industry.present?

  job
end

Job.import jobs
Job.reindex

Industry.all.each do |industry|
  job_count = Job.search { fulltext "\"#{industry.name}\"" }
  industry.update(job_count: job_count.total)
end

City.all.each do |city|
  job_count = Job.search { fulltext "\"#{city.name}\"" }
  city.update(job_count: job_count.total)
end