class JobsController < ApplicationController
  def index
    if params[:search].present?
      @jobs = Job.search do
        fulltext params[:search] do
          boost_fields name: 10
        end
        order_by(:score, :desc)
      end.results
    end
    # list cities, job,industry
    @top_jobs = Job.latest_jobs
    @top_cities = City.top_cities
    @top_industries = Industry.top_industries
  end

  # def city_jobs
  #   @city_name = params[:city_name]
    
  #     @jobs = Job.search do fulltext "\"#{params[:city_name]}\"" 
  #     paginate page: 1, per_page: Job.count
  #     end.results
  #     @job_count = @jobs.total_count
  #     @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(10)
  #   render 'joblist'
  # end
  # def city_jobs
  #   city_name = params[:city_name].to_s
  #   @city_display = city_name
  
  #   @search = Job.search do
  #     if city_name.present?
  #       fulltext city_name do
  #         fields(:city_name)
  #         phrase_fields(:city_name)
  #         boost_fields(:city_name => 2.0)
  #         minimum_match 1
  #       end
  #     end
  #     paginate :page => params[:page], :per_page => 20
  #   end
  
  #   @jobs = @search.results
  #   @job_count = @search.total
  
  #   render 'joblist'
  # end
  
  def city_jobs
    city_name = params[:city_name]
    @city_display = city_name
  
    @search = Job.search do
      if city_name.start_with?('"') && city_name.end_with?('"')
        # Tìm kiếm chính xác cụm từ
        fulltext city_name do
          fields(:name,:city_name) # Replace :field1, :field2, :field3 with the actual fields you want to search
        end
      else
        # Tìm kiếm từng từ riêng lẻ
        keywords "\"#{city_name}\""
      end
  
      paginate page: 1, per_page: Job.count
    end
  
    @jobs = @search.results
    @job_count = @jobs.count
    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(20)
    render 'joblist'
  end
  
  
  
  
  
  
  
end  
