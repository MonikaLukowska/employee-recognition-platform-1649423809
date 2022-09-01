require 'csv'

module AdminUsers
  class OrdersController < AdminUsers::ApplicationController
    def export
      @orders = Order.all.includes([:employee])

      respond_to do |format|
        format.csv do
          response.headers['Content-Type'] = 'text/csv'
          response.headers['Content-Disposition'] = "attachment; filename=orders_#{Time.zone.today}.csv"
          render template: 'admin_users/orders/export'
        end
      end
    end
  end
end
