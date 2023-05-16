class JobsController < ApplicationController
  def index
    @jobs = Job.all.page(params[:page]).per(5)
    @countJob = Job.total_jobs_count
    @latestJobs = Job.latestJobs
    @topCities = Job.topCities

  end

  def search
		@search = Job.search(include: [:comments]) do
		  keywords(params[:q])
		end
	end

  def import
    file = params[:file]
    jobs = SmarterCSV.process(file.path)
    Job.create!(jobs)
    redirect_to root_path, notice: 'Imported successfully'
  end
end
