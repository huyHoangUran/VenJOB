  class AdminSessionsController < ApplicationController
    layout 'admin', only: :index

    

    def index
      if session[:admin_id].nil?
        redirect_to admin_login_path, notice: "Bạn cần đăng nhập để truy cập trang này."
      else
        @applied_jobs= Apply.order(created_at: :desc).page(params[:page]).per(1)
        @cities = City.all
        @industries = Industry.all
        render :index
        # Xử lý logic khi admin đã đăng nhập
      end
    end
    def new
      if session[:admin_id].present?
        # Lấy thông tin admin từ session
        admin = Admin.find(session[:admin_id])
        
        redirect_to admin_applies_path, notice: "Now logged in"
      else
        @admin = Admin.new
      end
    end
    
    
    def search_jobs  
      @cities = City.all
      @industries = Industry.all
      @user_find = Apply.find_by(email: params[:email]) if !params[:email].nil?
      if @user_find.nil?
        u_apply = Apply.find_by(email: params[:email])
        @user_find = u_apply&.user
      end

      if !@user_find.nil? && params[:date_from].present? && params[:date_to].present?
        applied = @user_find.applies.where(created_at: params[:date_from]..params[:date_to])
      elsif !@user_find.nil? && params[:date_from].blank? && params[:date_to].blank?
        applied = Apply.where(email: params[:email])
      elsif @user_find.nil? && params[:date_from].present? && params[:date_to].present?
        applied = Apply.where(created_at: params[:date_from]..params[:date_to])
      elsif params[:email].present? && @user_find.nil?
        @applied_jobs = []
        render :index
        return
      else
        applied = Apply.all
      end
      
      if params[:industry_name].present? || params[:city_name].present?
        ids_job = applied.pluck(:job_id)
        search = Job.search do
          fulltext "\"#{params[:city_name]}\"" "\"#{params[:industry_name]}\""
          with(:id, ids_job)
          paginate(page: 1, per_page: Job.count)
        end
        id_job_search = search.results.map(&:id)
        @matched_applied = applied.select { |apply| id_job_search.include?(apply.job_id) }
      else
        @matched_applied = applied
      end
      ids_apply = @matched_applied.map(&:id)
      @results = Apply.includes(:job).where(id: ids_apply)
      @results.each do |apply|
        utc_time = Time.strptime(apply.created_at.to_s, "%Y-%m-%d %H:%M:%S")
        apply.created_at = utc_time
      end
      $ids_applied = @results.map(&:id)
      @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)
      @applied_jobs = @results
      render :index
    end

    def create
  if session[:admin_id].present?
    redirect_to admin_applies_path, notice: "Already logged in."
  else
    admin = Admin.find_by(login_id: params[:login_id])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_applies_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login credentials."
      render :new
    end
  end
end


    def destroy
      session[:admin_id] = nil
      redirect_to jobs_path, notice: "Logged out successfully."
    end
  end
