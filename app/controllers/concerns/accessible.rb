module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_admin_user
      flash.clear
      # if you have rails_admin. You can redirect anywhere really

      redirect_to(stored_location_for(:admin_user) || admin_dashboard_path)
      set_flash_message! :notice, :signed_in
      nil

    elsif current_employee
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(stored_location_for(:employee) || root_path)
      set_flash_message! :notice, :signed_in
    end
  end
end
