class RegistrationsController < Devise::RegistrationsController
  before_action :find_user_by_confirmation_token, only: [:edit, :update]
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      resource.send_confirmation_instructions
      sign_out(resource) 
      redirect_to register_2_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def thanks
    render :thanks
  end

end
