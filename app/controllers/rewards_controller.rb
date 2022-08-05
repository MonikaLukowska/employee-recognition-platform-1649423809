class RewardsController < ApplicationController
  before_action :authenticate_employee!
  def index
    pagy, rewards = pagy(Reward.order(created_at: :desc), items: 3)
    render :index, locals: { rewards: rewards, pagy: pagy }
  end

  def show
    render :show, locals: { reward: reward }
  end

  private

  def reward
    @reward ||= Reward.find(params[:id])
  end
end
