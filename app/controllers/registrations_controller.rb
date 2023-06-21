class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      sign_out(resource)
      redirect_to register_2_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
  
    resource_updated = update_resource(resource, account_update_params.permit(:name, :email, :my_cv, :password, :current_password))
    yield resource if block_given?
  
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
  
      redirect_to my_path, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
  
  def thanks
    render  'thanks'
  end


  def account_update_params
    permitted_params = params.require(:user).permit(:name, :email, :my_cv, :password, :current_password)
    permitted_params.delete(:my_cv) if permitted_params[:my_cv].blank?
    permitted_params
  end
  
  
  def update_resource(resource, params)
    resource.update_with_password(params)
  end
end
