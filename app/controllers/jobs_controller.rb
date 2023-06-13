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
    @job_counts = Job.count
    @top_jobs = Job.latest_jobs
    @top_cities = City.top_cities
    @top_industries = Industry.top_industries
  end
end
