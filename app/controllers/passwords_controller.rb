
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
      resource.reset_password_token = params[:reset_password_token]
    end

     def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      yield resource if block_given?

      if resource.errors.empty?
        resource.unlock_access! if unlockable?(resource)
        if resource_class.sign_in_after_reset_password
          flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
          set_flash_message!(:notice, flash_message)
          resource.after_database_authentication
          sign_in(resource_name, resource)
        else
          set_flash_message!(:notice, :updated_not_active)
        end
        binding.pry
        respond_with resource, location: after_resetting_reset_password_path_for(resource)
      else
        set_minimum_password_length
        respond_with resource
      end
    end
  end
