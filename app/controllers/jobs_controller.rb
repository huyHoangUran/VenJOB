class JobsController < ApplicationController
  def index
    # list cities, job,industry
    @job_counts = Job.count
    @top_jobs = Job.latest_jobs
    @top_cities = City.top_cities
    @top_industries = Industry.top_industries
  end
  def city_jobs
    city_name = params[:search]
    @city_display = city_name
  
    @search = Job.search do
        keywords  city_name
      paginate page: 1, per_page: Job.count
    end
  
    @jobs = @search.results
    @job_count = @jobs.count
    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(20)
    render 'joblist'
  end

  def city_search
    city_name = params[:city_name]
    @city_display = city_name
  
    @search = Job.search do
      fulltext "\"#{city_name}\""
      paginate page: 1, per_page: Job.count
    end
  
    @jobs = @search.results
    @job_count = @jobs.count
    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(20)
    render 'joblist'
  end
  def show
    @job = Job.find(params[:id])
    session[:job_id] = @job.id
    user = current_user
    if user.present?  
      if user.histories.exists?(job_id: @job.id)
        # Nếu đã tồn tại, cập nhật lại trường updated_at của bản ghi
        user.histories.find_by(job_id: @job.id).touch
        # Kết thúc action
        return
      end
      if user.histories.count >= 20
        old_history = user.histories.order(updated_at: :asc).first
        old_history.destroy
      end
      user.histories.create(job: @job, user_id: current_user.id)
    end
    # Các xử lý khác cho action sho
  end
  
end  
