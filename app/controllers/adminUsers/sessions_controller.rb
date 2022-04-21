# frozen_string_literal: true

module AdminUsers
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]


    # GET /resource/sign_in

    # POST /resource/sign_in

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    def after_sign_in_path_for(resource)
      super(resource)
      admin_dashboard_path
    end

    def after_sign_out_path_for(resource)
      super(resource)
      new_admin_user_session_path
    end

    # def after_sign_in_path_for(resource)
    #   super(resource)
    #   admin_dashboard_path
    # end
    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
