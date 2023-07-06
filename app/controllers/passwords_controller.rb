
  class PasswordsController < Devise::PasswordsController
    prepend_before_action :require_no_authentication
    # Render the #edit only if coming from a reset password email link
    append_before_action :assert_reset_token_passed, only: :edit
    def new
      self.resource = resource_class.new
    end
    

    def edit
      self.resource = resource_class.new
      set_minimum_password_length
    
      reset_password_token = params[:token]
      @user = resource_class.with_reset_password_token(params[:token])
      @user_email = @user&.email if @user
      resource.reset_password_token = params[:token]
    end

    def assert_reset_token_passed
      if params[:token].blank?
        set_flash_message(:alert, :no_token)
        redirect_to new_session_path(resource_name)
      end
    end
  end
