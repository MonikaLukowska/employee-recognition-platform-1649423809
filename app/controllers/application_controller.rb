# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :employee_not_authorized

  private

  def employee_not_authorized
    redirect_to kudos_path, alert: 'You cannot edit/remove this kudo'
  end

  def pundit_user
    current_employee
  end
end
