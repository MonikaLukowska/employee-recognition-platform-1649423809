module AdminUsers
  class KudosController < AdminUsers::ApplicationController
    def index
      render :index, locals: { kudos: Kudo.includes(:receiver, :giver, :company_value) }
    end

    def destroy
      kudo.destroy
      increase_giver_available_kudos
      redirect_to admin_users_kudos_path, notice: 'Kudo was successfully destroyed.'
    end

    private

    def kudo
      @kudo ||= Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:id, :title, :content, :receiver_id, :giver_id, :company_value_id)
    end

    def increase_giver_available_kudos
      kudo.giver.increment(:number_of_available_kudos, 1).save
    end
  end
end
