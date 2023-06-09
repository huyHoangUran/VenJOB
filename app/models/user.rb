class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  after_create :send_registration_confirmation_email       
  before_create :generate_confirmation_token
  
  has_one_attached :my_cv
  # validates :my_cv, presence: true
  # validates :password, presence: true, if: :password_required?
  # validates :password_confirmation, presence: true, if: :password_required?
  validates :email, presence: true, uniqueness: true, on: :create
  validates :name, presence: true, length: {maximum: 200}, on: :update
  validates :password, presence: true, length: {minimum: 8}, confirmation: true, on: :update
  validates :password_confirmation, presence: true, on: :update

  private

  def password_required?
    false
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  def send_registration_confirmation_email
    # UserMailer.registration_confirmation(self).deliver_now
    UserMailer.registration_confirmation(self).deliver_now
  end
end
