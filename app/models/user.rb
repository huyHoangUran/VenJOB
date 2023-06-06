class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  after_create :send_registration_confirmation_email       
  before_create :generate_confirmation_token
  validates :password, presence: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  after_create :send_registration_confirmation_email

  private

  def password_required?
    false
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  def send_registration_confirmation_email
    UserMailer.registration_confirmation(self).deliver_later
  end
end
