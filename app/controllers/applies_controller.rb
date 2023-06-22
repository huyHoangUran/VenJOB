class AppliesController < ApplicationController
  before_action :authenticate_user!

  def new_apply
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