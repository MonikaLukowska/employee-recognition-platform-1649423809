# frozen_string_literal: true

class ApplicationController < ActionController::Base
  devise_group :user, contains: [:employee, :admin_user]
  before_action :authenticate_user!
end
