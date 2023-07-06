class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :favourites
  has_many :applies
  has_many :histories
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable
  # validates :email, presence: true, uniqueness: true, on: :create
  validates :name, presence: true, length: {maximum: 200}, on: :update
  validates :password, presence: true, length: {minimum: 8}, confirmation: true, on: :update

  # use to upload files
  mount_uploader :my_cv, MyCvUploader
  validate :validate_my_cv_size
  validate :validate_my_cv_format
  private

  def validate_my_cv_size
    if my_cv.present? && my_cv.size > 5.megabytes
      errors.add(:my_cv, "should be less than 5MB")
    end
  end

  def validate_my_cv_format
    if my_cv.present? && !my_cv.file.extension.in?(%w[doc pdf xls])
      errors.add(:my_cv, "should be a doc, pdf, or xls file")
    end
  end

  private

  def password_required?
    false
  end
  
end
