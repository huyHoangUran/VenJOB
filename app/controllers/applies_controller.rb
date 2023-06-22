class AppliesController < ApplicationController
  before_action :authenticate_user!

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
  
  private

  def apply_params
    params.require(:apply).permit(:email, :fullname, :cv, :job_id, :user_id)
  end

  def submit_params
    params.require(:apply).permit(:email, :fullname, :cv, :job_id, :user_id)
  end
end