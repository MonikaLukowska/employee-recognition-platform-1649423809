module Employee
  class ApplicationController < ApplicationController
    before_action :authenticate_employee!
  end
end
