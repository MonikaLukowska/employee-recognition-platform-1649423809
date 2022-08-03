class KudosController < ApplicationController
  before_action :authenticate_employee!
  def index
    render :index, locals: { kudos: Kudo.includes(:receiver, :giver, :company_value).order(created_at: :desc) }
  end

  def show
    render :show, locals: { kudo: kudo }
  end

  def new
    render :new, locals: { kudo: Kudo.new }
  end

  def edit
    render :edit, locals: { kudo: kudo }
  end

  def create
    record = Kudo.new(kudo_params)
    record.giver = current_employee

    if record.save
      decrease_giver_available_kudos
      redirect_to kudos_path, notice: 'Kudo was successfully created.'
    else
      render :new, locals: { kudo: record }
    end
  end

  def update
    authorize kudo

    if kudo.update(kudo_params)
      redirect_to kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit, locals: { kudo: kudo }
    end
  end

  def destroy
    authorize kudo

    kudo.destroy
    increase_giver_available_kudos
    redirect_to kudos_path, notice: 'Kudo was successfully destroyed.'
  end

  private

  def kudo
    @kudo ||= Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:id, :title, :content, :receiver_id, :giver_id, :company_value_id)
  end

  def decrease_giver_available_kudos
    current_employee.decrement(:number_of_available_kudos, 1).save
  end

  def increase_giver_available_kudos
    kudo.giver.increment(:number_of_available_kudos, 1).save
  end
end
