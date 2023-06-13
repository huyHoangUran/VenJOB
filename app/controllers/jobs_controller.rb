class JobsController < ApplicationController
  def index
    # list cities, job,industry
    @job_counts = Job.count
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
    city_name = params[:keyword]
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
    search_keyword = params[:search]
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
  
end  
