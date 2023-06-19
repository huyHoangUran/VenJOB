
  class PasswordsController < Devise::PasswordsController
  
    def new
      self.resource = resource_class.new
    end
    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      yield resource if block_given?
  
      if successfully_sent?(resource)
        respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
      else
        respond_with(resource)
      end
    end

    def edit
      self.resource = resource_class.new
      set_minimum_password_length
    
      reset_password_token = params[:reset_password_token]
      @user = resource_class.with_reset_password_token(params[:reset_password_token])
      @user_email = @user&.email if @user
    end

    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      if resource.errors.empty?
        sign_in(resource_name, resource)
        redirect_to root_path
      else
        render :edit
      end
    end
  end
