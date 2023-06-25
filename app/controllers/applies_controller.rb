class AppliesController < ApplicationController
  before_action :authenticate_user!
  def index
    @applied_jobs = current_user.applies

  end
  
  def new_apply
    @apply = Apply.new
  end

  def create_apply
    apply = Apply.new(apply_params)
    apply.job_id = session[:job_id]
    apply.user_id = current_user.id
    session[:apply] = apply
    redirect_to show_confirm_apply_path
  end

  def show_confirm
    @apply = Apply.new
  end
  
  def submit_apply
    apply = Apply.new(submit_params)
    apply_info = session[:apply]
    apply_info["user_email"] = apply.email
    apply_info["user_name"] = apply.user.name
    apply_info["cv"] = 'http://127.0.0.1:3000'+apply.user.my_cv.url.to_s
    apply_info["job_title"] = apply.job.name 
    apply_info["job_location"] = apply.job.work_place
    apply_info["company"] = apply.job.company_name
    apply.save!
    session.delete(:apply)
    session.delete(:job_id)
    UserMailer.apply_confirmation(apply_info).deliver_later
    redirect_to done_apply_path
  end

  def done_apply
  end

  private

  def apply_params
    params.require(:apply).permit(:email, :fullname, :cv, :job_id, :user_id)
  end

  def submit_params
    params.require(:apply).permit(:email, :fullname, :cv, :job_id, :user_id)
  end
end