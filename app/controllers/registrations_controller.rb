class RegistrationsController < Devise::RegistrationsController
  before_action :find_user_by_confirmation_token, only: [:edit, :update]
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      sign_out(resource) 
      redirect_to thanks_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def edit
    # Hiển thị form chỉnh sửa thông tin người dùng
  end

  def update
    if @user.update(user_params)
      # Cập nhật thông tin người dùng thành công
      redirect_to root_path, notice: 'Thông tin người dùng đã được cập nhật.'
    else
      # Xảy ra lỗi, hiển thị lại form
      render :edit
    end
  end

  private

  def find_user_by_confirmation_token
    @user = User.find_by(confirmation_token: params[:confirmation_token])

    # Kiểm tra xem confirmation_token có hợp lệ và người dùng đã xác nhận không
    if @user.nil? || !@user.confirmed?
      redirect_to new_user_session_path, alert: 'Bạn cần đăng nhập hoặc đăng ký để tiếp tục.'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :my_cv)
  end
end
