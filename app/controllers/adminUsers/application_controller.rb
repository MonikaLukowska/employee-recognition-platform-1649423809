module AdminUsers
  class ApplicationController < ApplicationController
    before_action :authenticate_admin_user!
    layout 'admin'
  end
end
