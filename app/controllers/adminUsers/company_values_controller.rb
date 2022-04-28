module AdminUsers
  class CompanyValuesController < AdminUsers::ApplicationController
    before_action :set_company_value, only: %i[edit update destroy]

    # GET /company_values
    def index
      @company_values = CompanyValue.order(:id)
    end

    # GET /company_values/1/edit
    def edit; end

    # PATCH/PUT /company_values/1
    def update
      if @company_value.update(company_value_params)
        redirect_to admin_users_company_values_path, notice: 'Company Value was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /company_values/1
    def destroy
      @company_value.destroy
      redirect_to admin_users_company_values_path, notice: 'Company Value was successfully destroyed.'
    end

    private

    def set_company_value
      @company_value = CompanyValue.find(params[:id])
    end

    def company_value_params
      params.require(:company_value).permit(:id, :title)
    end
  end
end
