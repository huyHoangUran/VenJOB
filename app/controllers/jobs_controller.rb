class JobsController < ApplicationController
  def index
    if params[:q].present?
      @search = Job.search do
        fulltext params[:q]
        # Các điều kiện tìm kiếm khác nếu có
      end
      @jobs = @search.results
    else
      @jobs = Job.all
    end
  end
end
