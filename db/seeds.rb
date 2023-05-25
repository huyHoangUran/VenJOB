# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# require 'csv'
# require 'activerecord-import'

# Job.delete_all
# Industry.delete_all
# City.delete_all

# ActiveRecord::Base.connection.execute('TRUNCATE TABLE jobs;')
# ActiveRecord::Base.connection.execute('TRUNCATE TABLE cities;')
# ActiveRecord::Base.connection.execute('TRUNCATE TABLE industries;')

# def normalize_city_name(city_name)
#   city_mappings = {
#     'Bắc Cạn' => 'Bắc Kạn',
#     'Xã Xuân Giao' => 'Lào Cai',
#     'Thừa Thiên Huế' => 'Thừa Thiên - Huế'
#   }
#   city_mappings.fetch(city_name, city_name.gsub(/[\["\]]/, ''))
# end

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'jobs.csv'))
# csv = CSV.parse(csv_text, headers: true)

# # Chuẩn hóa và thêm dữ liệu cho bảng "industry" và "city"
# industry_names = []
# cities = [
#   "An Giang", "Bà Rịa - Vũng Tàu", "Bắc Giang", "Bắc Kạn", "Bạc Liêu", "Bắc Ninh",
#   "Bến Tre", "Bình Định", "Bình Dương", "Bình Phước", "Bình Thuận", "Cà Mau",
#   "Cần Thơ", "Cao Bằng", "Đà Nẵng", "Đắk Lắk", "Đắk Nông", "Điện Biên", "Đồng Nai",
#   "Đồng Tháp", "Gia Lai", "Hà Giang", "Hà Nam", "Hà Nội", "Hà Tĩnh", "Hải Dương",
#   "Hải Phòng", "Hậu Giang", "Hòa Bình", "Hưng Yên", "Khánh Hòa", "Kiên Giang",
#   "Kon Tum", "Lai Châu", "Lâm Đồng", "Lạng Sơn", "Lào Cai", "Long An", "Nam Định",
#   "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ", "Phú Yên", "Quảng Bình",
#   "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng", "Sơn La",
#   "Tây Ninh", "Thái Bình", "Thái Nguyên", "Thanh Hóa", "Thừa Thiên Huế",
#   "Tiền Giang", "TP Hồ Chí Minh", "Trà Vinh", "Tuyên Quang", "Vĩnh Long",
#   "Vĩnh Phúc", "Yên Bái"
# ]


# csv.each do |row|
#   industry_name = row['category'].to_s.gsub(/[\["\]]/, '').strip
#   industry_names << industry_name if industry_name.present?

#   city_name = normalize_city_name(row['work_place'])
#   city_names << city_name if city_name.present?
# end

# industry_names.uniq!
# city_names.uniq!

# # Thêm dữ liệu vào bảng "industry"
# industries = industry_names.map do |industry_name|
#   Industry.new(name: industry_name)
# end
# Industry.import industries

# # Thêm dữ liệu vào bảng "city"
# cities = city_names.map do |city_name|
#   City.new(name: city_name)
# end
# City.import cities

# # Lấy danh sách tất cả các City và Industry đã được tạo
# city_map = City.where(name: city_names).index_by(&:name)
# industry_map = Industry.where(name: industry_names).index_by(&:name)

# # Thêm dữ liệu vào bảng "job"
# jobs = csv.map do |row|
#   city_name = normalize_city_name(row['work_place'])
#   industry_name = row['category']

#   city_name = normalize_city_name(city_name)
#   industry_name = industry_name.gsub(/[\["\]]/, '') if industry_name

#   city = city_map[city_name]
#   industry = industry_map[industry_name]

#   job = Job.new
#   job.benefit = row['benefit']
#   job.company_address = row['company_address']
#   job.company_district = row['company_district']
#   job.company_name = row['company_name']
#   job.company_province = row['company_province']
#   job.description = row['description']
#   job.level = row['level']
#   job.name = row['name']
#   job.requirement = row['requirement']
#   job.salary = row['salary']
#   job.type_job = row['type']
#   job.contact_email = row['contact_email']
#   job.contact_name = row['contact_name']
#   job.contact_phone = row['contact_phone']

#   if city.present?
#     job.city_id = city.id
#   else
#     # Xử lý khi thành phố không tồn tại trong city_map
#     # Có thể bỏ qua công việc hoặc thực hiện xử lý phù hợp tại đây
#   end

#   job.industry_id = industry.id if industry.present?

#   job
# end

# Job.import jobs
# Job.reindex



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
  city_mappings.fetch(city_name, city_name.gsub(/[\["\]]/, ''))
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'jobs.csv'))
csv = CSV.parse(csv_text, headers: true)

# Tạo danh sách tên ngành nghề
industry_names = []
csv.each do |row|
  industry_name = row['category'].to_s.gsub(/[\["\]]/, '').strip
  industry_names << industry_name if industry_name.present?
end
industry_names.uniq!

# Tạo danh sách đối tượng Industry
industries = industry_names.map { |industry_name| Industry.new(name: industry_name) }

# Import dữ liệu vào bảng "industry"
Industry.import industries

# Thêm dữ liệu vào bảng "city"
cities_data = [
  'Hà Nội', 'Hồ Chí Minh', 'Hải Phòng', 'Đà Nẵng', 'Cần Thơ', # Danh sách 5 thành phố lớn
  # Danh sách các tỉnh thành khác
  'Lào Cai', 'Yên Bái', 'Điện Biên', 'Lai Châu', 'Sơn La', 'Hòa Bình',
  'Thái Nguyên', 'Lạng Sơn', 'Bắc Kạn', 'Tuyên Quang', 'Lạng Sơn', 'Quảng Ninh',
  'Bắc Giang', 'Phú Thọ', 'Vĩnh Phúc', 'Bắc Ninh', 'Hải Dương', 'Hưng Yên',
  'Thái Bình', 'Hà Nam', 'Nam Định', 'Ninh Bình', 'Thanh Hóa', 'Nghệ An',
  'Hà Tĩnh', 'Quảng Bình', 'Quảng Trị', 'Thừa Thiên Huế', 'Quảng Nam', 'Quảng Ngãi',
  'Bình Định', 'Phú Yên', 'Khánh Hòa', 'Ninh Thuận', 'Bình Thuận', 'Kon Tum',
  'Gia Lai', 'Đắk Lắk', 'Đắk Nông', 'Lâm Đồng', 'Bình Phước', 'Tây Ninh',
  'Bình Dương', 'Đồng Nai', 'Bà Rịa - Vũng Tàu', 'Long An', 'Tiền Giang', 'Bến Tre',
  'Trà Vinh', 'Vĩnh Long', 'Đồng Tháp', 'An Giang', 'Kiên Giang', 'Cần Thơ',
  'Hậu Giang', 'Sóc Trăng', 'Bạc Liêu', 'Cà Mau'
]

cities = cities_data.map { |city_name| City.new(name: city_name) }
City.import cities
city_map = City.where(name: cities_data).index_by(&:name)

# Thêm dữ liệu vào bảng "job" và cập nhật job_count trong bảng "city"
jobs = csv.map do |row|
  city_name = normalize_city_name(row['work_place'])
  industry_name = row['category']

  city_name = normalize_city_name(city_name)
  industry_name = industry_name.gsub(/[\["\]]/, '') if industry_name

  city = city_map[city_name]
  industry = Industry.find_by(name: industry_name)

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

  if city.present?
    job.city_id = city.id
    if city_name != 'Khác'
      city.job_count ||= 1

      city.job_count += 1
      city.save
    end
  end
  if industry.present?
    industry.job_count ||= 1
    industry.job_count += 1
    industry.save
  end

  job.industry_id = industry.id if industry.present?

  job
end

Job.import jobs
Job.reindex
# Lấy danh sách thành phố và số lượng công việc từ trường work_place
jobs_industry = Industry.all.map do |industry|
  job_count = Job.search { fulltext "\"#{industry.name}\"" }

  industry.update(job_count: job_count.total)
end
jobs_city = City.all.map do |city|
  job_count = Job.search { fulltext "\"#{city.name}\"" }
  city.update(job_count: job_count.total)
end