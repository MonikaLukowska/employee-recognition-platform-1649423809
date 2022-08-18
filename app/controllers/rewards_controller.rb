class RewardsController < ApplicationController
  before_action :authenticate_employee!
  def index
    filtred_rewards = RewardsQuery.new(params).results
    pagy, rewards = pagy(filtred_rewards, items: 3)
    render :index, locals: { rewards: rewards, pagy: pagy,
                             categories: Category.order(title: :asc),
                             category: category_params }
  end

  def show
    render :show, locals: { reward: reward }
  end

  private

  def reward
    @reward ||= Reward.find(params[:id])
  end

  def category_params
    @category = params[:category]
  end
end
