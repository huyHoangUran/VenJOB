class JobsController < ApplicationController
  def index
    @topJops = Job.latest_jobs
    @topCities = City.topCities
  end
end
