class CitiesController < ApplicationController
    def index
        @Cities = City.where(country: "VN").order(job_count: :desc).all
        @CitiesInter = City.where(country: "NN").order(job_count: :desc).all
      end
end
