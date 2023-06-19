class FavouritesController < ApplicationController
  before_action :authenticate_user! # Đảm bảo người dùng đã đăng nhập trước khi thực hiện các hành động yêu thích
  def index
    @jobs = current_user.favourites
  end
  
  def create
    @job = Job.find(params[:job_id])
    current_user.favourites.create(job: @job)
    redirect_back(fallback_location: root_path, notice: 'Job added to favourites successfully.')
  end

  def destroy
    @favourite = current_user.favourites.find_by(id: params[:id])
    @job = @favourite.job if @favourite
    if @favourite&.destroy
      redirect_back(fallback_location: root_path, notice: 'Job removed from favourites successfully.')
    else
      redirect_back(fallback_location: root_path, alert: 'Failed to remove job from favourites.')
    end
  end
end
