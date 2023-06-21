class AppliesController < ApplicationController
  def apply
    @user = current_user
    @job_id = params[:job_id] # Lấy ID của job từ URL hoặc thông qua tham số truyền vào
  end
  
  def submit_apply
    # Lưu dữ liệu từ Form 1 vào cơ sở dữ liệu
    @user = current_user
    @user.fullname = params[:fullname]
    @user.email = params[:email]
    @user.save

    redirect_to confirm_path
  end

  def confirm
    @user = current_user
  end

  def submit_confirm
    # Lưu dữ liệu từ Form 2 vào cơ sở dữ liệu
    @user = current_user
    @user.fullname = params[:fullname]
    @user.email = params[:email]
    @user.save

    redirect_to confirmation_path
  end

  def confirmation
    # Hiển thị thông báo hoàn tất
  end
end
