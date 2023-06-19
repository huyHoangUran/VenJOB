class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :favourites
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable
  # validates :email, presence: true, uniqueness: true, on: :create
  validates :name, presence: true, length: {maximum: 200}, on: :update
  validates :password, presence: true, length: {minimum: 8}, confirmation: true, on: :update
  validates :password_confirmation, presence: true, on: :update

  # use to upload files
  mount_uploader :my_cv, MyCvUploader
  


  private

  def password_required?
    false
  end
  
end
