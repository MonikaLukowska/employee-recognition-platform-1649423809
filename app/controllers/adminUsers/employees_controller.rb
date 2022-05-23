module AdminUsers
  class EmployeesController < AdminUsers::ApplicationController
    def index
      render :index, locals: { employees: Employee.order(email: :asc) }
    end

    def edit
      render :edit, locals: { employee: employee }
    end

    def update
      if (employee_params[:password].blank? &&
         employee.update_without_password(employee_params.except(:password))) ||
         employee.update(employee_params)
        redirect_to admin_users_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit, locals: { employee: employee }
      end
    end

    def destroy
      employee.destroy
      redirect_to admin_users_employees_path, notice: 'Employee was successfully destroyed.'
    end

    private

    def employee
      @employee ||= Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:id, :email, :password, :number_of_available_kudos)
    end
  end
end
