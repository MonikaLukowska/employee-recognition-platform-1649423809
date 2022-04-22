module AdminUsers
  class KudosController < AdminUsers::ApplicationController
    before_action :set_kudo, only: %i[destroy]

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
  end
end
