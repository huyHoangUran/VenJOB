class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    @user = current_user
  end

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
        
        if params[:user][:my_cv].present?
          @user.my_cv = params[:user][:my_cv] # Gán giá trị mới cho my_cv
          @user.save
        end
        @user.update(confirmed_at: Time.now)
        sign_in(@user)
  
        redirect_to my_path, notice: 'Password updated successfully.'
      else
        render :edit
      end
    else
      head :not_found
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :my_cv)
  end

  def confirmation_token_expired?
    confirmation_sent_at = @user.confirmation_sent_at
    confirmation_sent_at.present? && confirmation_sent_at < 24.hours.ago
  end
    
end