class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :password, presence: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?


  private

  def password_required?
    false
  end
end
