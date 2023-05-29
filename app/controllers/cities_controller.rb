class CitiesController < ApplicationController
    def index
        @topCities = City.order(job_count: :desc).all
      end
end
