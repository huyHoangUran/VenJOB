class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    @confirmation_token = user.confirmation_token
    
    # Tạo đường dẫn đến trang cập nhật thông tin
    @confirmation_url = edit_user_url(user, confirmation_token: @confirmation_token)
    
    # Gửi email với đường dẫn xác nhận
    mail(to: @user.email, subject: 'Xác nhận tài khoản')
  end
  

  def apply_confirmation(apply_info)
    @user_name = apply_info["user_name"]
    @user_email = apply_info["user_email"]
    @cv_url = apply_info["cv"]
    @job_title = apply_info["job_title"]
    @job_location = apply_info["job_location"]
    @company = apply_info["company"]

    mail(to: @user_email, subject: 'Xác nhận nộp đơn thành công')
  end
end
