class AdminSessionsController < ApplicationController
  layout 'admin', only: :index
  def index
    if session[:admin_id].nil?
      redirect_to admin_login_path, notice: "Bạn cần đăng nhập để truy cập trang này."
    else
      render :index
      # Xử lý logic khi admin đã đăng nhập
    end
  end
  
  def create
    admin = Admin.find_by(login_id: params[:login_id])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_index_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login credentials."
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to jobs_path, notice: "Logged out successfully."
  end
end
