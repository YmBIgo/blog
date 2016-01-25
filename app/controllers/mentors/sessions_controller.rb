class Mentors::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  before_action :check_user

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  private
  def check_user
    redirect_to root_path if current_user.present?
  end

end
