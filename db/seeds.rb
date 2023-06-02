require 'csv'

Job.delete_all
City.delete_all
Industry.delete_all

ActiveRecord::Base.connection.execute('TRUNCATE TABLE jobs;')
ActiveRecord::Base.connection.execute('TRUNCATE TABLE cities;')
ActiveRecord::Base.connection.execute('TRUNCATE TABLE industries;')

csv_file = Rails.root.join("lib/seeds/jobs.csv")


def map_city_name(city_name)
  city_mappings = {
    'Bắc Cạn' => 'Bắc Kạn',
    'Xã Xuân Giao' => 'Lào Cai',
    'Thừa Thiên Huế' => 'Thừa Thiên - Huế'
  }
  
  city_mappings.fetch(city_name, city_name.gsub(/[\["\]]/, ''))
end

cities_in_VN = ['Hà Nội', 'Hồ Chí Minh', 'Đà Nẵng', 'Hải Phòng', 'Cần Thơ', 'Bắc Giang', 'Bắc Kạn', 'Bạc Liêu', 'Bắc Ninh', 'Bến Tre', 'Bình Định', 'Bình Dương', 'Bình Phước', 'Bình Thuận', 'Cà Mau', 'Cao Bằng', 'Đắk Lắk', 'Đắk Nông', 'Điện Biên', 'Đồng Nai', 'Đồng Tháp', 'Gia Lai', 'Hà Giang', 'Hà Nam', 'Hà Tĩnh', 'Hải Dương', 'Hậu Giang', 'Hòa Bình', 'Hưng Yên', 'Khánh Hòa', 'Kiên Giang', 'Kon Tum', 'Lai Châu', 'Lâm Đồng', 'Lạng Sơn', 'Lào Cai', 'Long An', 'Nam Định', 'Nghệ An', 'Ninh Bình', 'Ninh Thuận', 'Phú Thọ', 'Quảng Bình', 'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị', 'Sóc Trăng', 'Sơn La', 'Tây Ninh', 'Thái Bình', 'Thái Nguyên', 'Thanh Hóa', 'Thừa Thiên - Huế', 'Tiền Giang', 'Trà Vinh', 'Tuyên Quang', 'Vĩnh Long', 'Vĩnh Phúc', 'Yên Bái']
cities = cities_in_VN.map { |city_name| { name: city_name } }
industries = []

CSV.foreach(csv_file, headers: true) do |row|
  city_name = row[6]
  city_name = map_city_name(city_name) unless city_name.nil?
  cities << { name: city_name } unless city_name.nil?
  industries << { name: row[1] } unless row[1].nil?
end

City.import cities, on_duplicate_key_ignore: true, validate: false
Industry.import industries, on_duplicate_key_ignore: true, validate: false

# binding.pry 

hash_industry = Industry.pluck(:name, :id).to_h
hash_city = City.pluck(:name, :id).to_h

jobs = []

CSV.foreach(csv_file, headers: true) do |row|
  city_id = hash_city[row[6]]
  industry_id = hash_industry[row[1]]
  
  jobs << Job.new(
    benefit: row[0],
    company_address: row[2],
    company_district: row[3],
    company_id: row[4],
    company_name: row[5],
    description: row[7],
    level: row[8],
    name: row[9],
    requirement: row[10],
    salary: row[11],
    type_work: row[12],
    contact_email: row[13],
    contact_name: row[14],
    contact_phone: row[15],
    work_place: row[16],
    industry_id: industry_id,
    city_id: city_id
  )
end

Job.import jobs, on_duplicate_key_update: %i[
  benefit company_address company_district company_id company_name work_place description level name
  requirement salary type_work contact_email contact_name contact_phone
], validate: false

Job.reindex

cities = City.includes(:jobs).all
industries = Industry.includes(:jobs).all

job_count_of_city = cities.map do |city|
  if city.name == 'Khác'
    job_count = Job.search do
      fulltext "\"#{city.name}\"" do
        fields(:city_name)
      end
    end
  else
    job_count = city.jobs.search { fulltext "\"#{city.name}\"" }
  end

  city.job_count = job_count.total
  city.save
  city
end

job_count_of_industry = industries.map do |industry|
  if industry.name == 'Khác'
    job_count = Job.search do
      fulltext "\"#{industry.name}\"" do
        fields(:industry_name)
      end
    end
  else
    job_count = industry.jobs.search { fulltext "\"#{industry.name}\"" }
  end

  industry.job_count = job_count.total
  industry.save
  industry
end

City.import job_count_of_city, on_duplicate_key_update: %i[job_count ], validate: false
Industry.import job_count_of_industry, on_duplicate_key_update: %i[job_count ], validate: false

