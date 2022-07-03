module AdminUsers
  module Employees
    class OrdersController < AdminUsers::ApplicationController
      def index
        render :index, locals: { orders: Order.where(employee: employee), employee: employee }
      end

      def employee
        @employee ||= Employee.find(params[:employee_id])
      end
    end
  end
end
