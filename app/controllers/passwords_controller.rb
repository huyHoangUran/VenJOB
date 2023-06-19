class PasswordsController < Devise::PasswordsController
  
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
  
    reset_password_token = params[:reset_password_token]
    @user = resource_class.with_reset_password_token(params[:reset_password_token])
    @user_email = @user&.email if @user
  end
  
  
end
