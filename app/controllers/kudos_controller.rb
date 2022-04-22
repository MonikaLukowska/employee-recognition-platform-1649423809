class KudosController < ApplicationController
  before_action :set_kudo, only: %i[show edit update destroy]
  before_action :require_same_giver, only: %i[edit update destroy]

  # GET /kudos
  def index
    @kudos = Kudo.all.includes(:receiver, :giver)
  end

  # GET /kudos/1
  def show; end

  # GET /kudos/new
  def new
    @kudo = Kudo.new
  end

  # GET /kudos/1/edit
  def edit; end

  # POST /kudos
  def create
    @kudo = Kudo.new(kudo_params)
    @kudo.giver_id = current_employee.id
    if @kudo.save
      redirect_to kudos_path, notice: 'Kudo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /kudos/1
  def update
    if @kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kudos/1
  def destroy
    @kudo.destroy
    redirect_to kudos_path, notice: 'Kudo was successfully destroyed.'
  end

  private

  def set_kudo
    @kudo = Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:id, :title, :content, :receiver_id, :giver_id)
  end

  def require_same_giver
    return unless current_employee != @kudo.giver

    flash[:alert] = 'You can only edit and delete your own kudos'
    redirect_to kudos_path
  end
end
