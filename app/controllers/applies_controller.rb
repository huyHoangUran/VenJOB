class AppliesController < ApplicationController
  def new
    @applied = Applied.new(job_id: params[:job_id])
  end
end
