module AdminUsers
  module Employees
    class OrdersController < AdminUsers::ApplicationController
      def index
        render :index, locals: { orders: Order.of_an_employee(employee).order(:status),
                                 employee: employee }
      end

      def update
        if order.not_delivered?
          order.delivered!
          redirect_back fallback_location: admin_users_employee_orders_path,
                        notice: 'Order has been delivered!'
        else
          redirect_back fallback_location: admin_users_employee_orders_path,
                        notice: 'Order has been already delivered!'
        end
      end

      def employee
        @employee ||= Employee.find(params[:employee_id])
      end

      def order
        @order ||= Order.find(params[:id])
      end
    end
  end
end
