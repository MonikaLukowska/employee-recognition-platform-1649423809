module AdminUsers
  class KudosController < AdminUsers::ApplicationController
    before_action :set_kudo, only: %i[destroy]
    before_action :set_giver, only: %i[destroy]
    after_action :increase_employee_available_kudos, only: %i[destroy]

    # GET /kudos
    def index
      @kudos = Kudo.all.includes(:receiver, :giver)
    end

    # DELETE /kudos/1
    def destroy
      @kudo.destroy
      redirect_to admin_users_kudos_path, notice: 'Kudo was successfully destroyed.'
    end

    private

    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:id, :title, :content, :receiver_id, :giver_id)
    end

    def set_giver
      @giver = Employee.find(@kudo.giver.id)
    end

    def increase_employee_available_kudos
      @giver.update(number_of_available_kudos: @giver.number_of_available_kudos + 1)
    end
  end
end
