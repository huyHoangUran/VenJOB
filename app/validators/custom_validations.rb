# app/validators/custom_validations.rb

class CustomValidations < ActiveModel::Validator
  def validate(record)
    unless record.persisted? # Chỉ áp dụng validate khi tạo mới tài khoản
      record.errors[:password] << 'cannot be blank' if record.password.blank?
      record.errors[:password_confirmation] << 'cannot be blank' if record.password_confirmation.blank?
    end
  end
end
