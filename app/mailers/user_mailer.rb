class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    @confirmation_token = user.confirmation_token
    
    # Tạo đường dẫn đến trang cập nhật thông tin
    @confirmation_url = edit_user_url(user, confirmation_token: @confirmation_token)
    
    # Gửi email với đường dẫn xác nhận
    mail(to: @user.email, subject: 'Xác nhận tài khoản')
  end
  
end
