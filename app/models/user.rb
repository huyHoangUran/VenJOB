class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable
  validates :email, presence: true, uniqueness: true, on: :create
  validates :name, presence: true, length: {maximum: 200}, on: :update
  validates :password, presence: true, length: {minimum: 8}, confirmation: true, on: :update
  validates :password_confirmation, presence: true, on: :update

  # use to upload files
  mount_uploader :my_cv, MyCvUploader
  validates :my_cv, file_size: { less_than_or_equal_to: 3.megabytes, message: "size exceeds the maximum limit (5MB)" },
                file_content_type: { allow: ['application/msword', 'application/pdf', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/zip'], message: "has an invalid format" },
                allow_blank: true,
                on: :update
  
  
  
end
