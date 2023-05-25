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

# Chuẩn hóa và thêm dữ liệu cho bảng "industry" và "city"
industry_names = []
city_names = []

csv.each do |row|
  industry_name = row['category'].to_s.gsub(/[\["\]]/, '').strip
  industry_names << industry_name if industry_name.present?

  city_name = normalize_city_name(row['work_place'])
  city_names << city_name if city_name.present?
end

industry_names.uniq!
city_names.uniq!

# Thêm dữ liệu vào bảng "industry"
industries = industry_names.map do |industry_name|
  Industry.new(name: industry_name)
end
Industry.import industries

# Thêm dữ liệu vào bảng "city"
cities = city_names.map do |city_name|
  if city_name == 'Khác'
    City.new(name: 'Nước ngoài')
  else
    City.new(name: city_name)
  end
end
City.import cities

# Lấy danh sách tất cả các City và Industry đã được tạo
city_map = City.where(name: city_names).index_by(&:name)
industry_map = Industry.where(name: industry_names).index_by(&:name)

# Thêm dữ liệu vào bảng "job"
jobs = csv.map do |row|
  city_name = normalize_city_name(row['work_place'])
  industry_name = row['category']

  city_name = normalize_city_name(city_name)
  industry_name = industry_name.gsub(/[\["\]]/, '') if industry_name

  city = city_map[city_name]
  industry = industry_map[industry_name]

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
    job.save
  else
    # Xử lý khi thành phố không tồn tại trong city_map
    # Có thể bỏ qua công việc hoặc thực hiện xử lý phù hợp tại đây
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
