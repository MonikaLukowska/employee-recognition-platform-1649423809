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

    def add_kudos
      render :add_kudos
    end

    def increase_number_of_available_kudos
      number_of_kudos = params[:number_of_kudos].to_i
      if number_of_kudos.between?(1, 20)
        Employee.transaction do
          Employee.all.each do |employee|
            employee.increment(:number_of_available_kudos, number_of_kudos).save!
          end
          redirect_to admin_users_employees_path, notice: 'Numbers of available kudos where increased succesfully'
        rescue StandardError => e
          render :add_kudos, notice: "Update failed. Reason: #{e}"
        end
      else
        render :add_kudos,
               notice: 'Invalid input, please enter a number between 1 and 20'
      end
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
