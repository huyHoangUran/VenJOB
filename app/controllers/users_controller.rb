class UsersController < ApplicationController
  def edit
    @user = User.find_by(confirmation_token: params[:confirmation_token])
    
    if @user.present? && @user.confirmed_at.nil?
      # Hiển thị form cập nhật thông tin người dùng
      render 'edit'
    elsif @user.present? && @user.confirmed_at.present?
      # Người dùng đã xác nhận tài khoản, không cho phép truy cập đường link xác nhận nữa
      redirect_to new_user_session_path
    else
      render json: { error: 'Confirmation token không hợp lệ' }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find_by(confirmation_token: params[:user][:confirmation_token])
  
    if @user.present?
      if @user.update(user_params)
        @user.my_cv.attach(params[:user][:my_cv]) if params[:user][:my_cv].present?
        @user.update(confirmed_at: Time.now)
        redirect_to new_user_session_path
      else
        render json: { error: 'Có lỗi xảy ra khi cập nhật mật khẩu' }, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation, :name, :my_cv)
  end
end