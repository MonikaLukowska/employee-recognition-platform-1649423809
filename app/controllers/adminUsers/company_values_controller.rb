module AdminUsers
  class CompanyValuesController < AdminUsers::ApplicationController
    def index
      render :index, locals: { company_values: CompanyValue.order(title: :asc) }
    end

    def edit
      render :edit, locals: { company_value: company_value }
    end

    def show
      render :show, locals: { company_value: company_value }
    end

    def new
      render :new, locals: { company_value: CompanyValue.new }
    end

    def create
      record = CompanyValue.new(company_value_params)

      if record.save
        redirect_to admin_users_company_value_path(record), notice: 'Company Value was successfully created'
      else
        render :new, locals: { company_value: record }
      end
    end

    def update
      if company_value.update(company_value_params)
        redirect_to admin_users_company_values_path, notice: 'Company Value was successfully updated.'
      else
        render :edit, locals: { company_value: company_value }
      end
    end

    def destroy
      company_value.destroy
      redirect_to admin_users_company_values_path, notice: 'Company Value was successfully destroyed.'
    end

    private

    def company_value
      @company_value ||= CompanyValue.find(params[:id])
    end

    def company_value_params
      params.require(:company_value).permit(:id, :title)
    end
  end
end
