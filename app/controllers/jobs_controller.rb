class JobsController < ApplicationController
  def index
    if params[:search].present?
      @jobs = Job.search do
        fulltext params[:search] do
          boost_fields name: 10
        end
        order_by(:score, :desc)
        order_by(:id, :desc)
      end.results
    end
    # list cities, job,industry
    @topJobs = Job.latest_jobs
    @topCities = City.topCities
    @topIndustries = Industry.topIndustries
  end

  def city_list
    @topCities = City.order(job_count: :desc).all.page(params[:page]).per(12)
    render 'jobs/citylist'
  end
  def industry_list
    @listIndustries = Industry.where.not(name: "Khác").order(job_count: :desc).page(params[:page]).per(12)
    render 'jobs/industrylist'
  end

end  
