class Job < ApplicationRecord
    self.inheritance_column = :type_job


    def self.import_columns
        [:benefit, :category, :company_address, :company_district, :company_id, :company_name, :company_province, :description, :level, :name, :requirement, :salary, :type, :contact_email, :contact_name, :contact_phone, :work_place,]
      end
end
