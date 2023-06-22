class Apply < ApplicationRecord
  belongs_to :job
  belongs_to :user  


  validates :fullname, :email, :cv, presence: true
end
