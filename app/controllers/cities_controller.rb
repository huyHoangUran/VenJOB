class CitiesController < ApplicationController
    def index
        @top_cities = City.order(job_count: :desc).all
      end
end
