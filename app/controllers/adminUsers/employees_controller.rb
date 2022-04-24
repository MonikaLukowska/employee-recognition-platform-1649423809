module AdminUsers
  class EmployeesController < AdminUsers::ApplicationController
    before_action :set_employee, only: %i[edit update destroy]

    # GET /employees
    def index
      @employees = Employee.all
    end

    # GET /employees/1/edit
    def edit; end

    # PATCH/PUT /kudos/1
    def update
      if @employee.update(employee_params)
        redirect_to admin_users_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /employees/1
    def destroy
      @employee.destroy
      redirect_to admin_users_employees_path, notice: 'Employee was successfully destroyed.'
    end

    private

    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:id, :email, :number_of_available_kudos)
    end
  end
end
