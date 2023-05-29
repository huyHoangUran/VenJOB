class IndustriesController < ApplicationController
    def index
        @list_industries = Industry.order(job_count: :desc).all
    end
end
