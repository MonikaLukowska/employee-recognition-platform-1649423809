class RewardsController < ApplicationController
  before_action :authenticate_employee!
  def index
    render :index, locals: { rewards: Reward.order(created_at: :desc) }
  end

  def show
    render :show, locals: { reward: reward }
  end

  private

  def reward
    @reward ||= Reward.find(params[:id])
  end
end
