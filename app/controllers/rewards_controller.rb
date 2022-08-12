class RewardsController < ApplicationController
  before_action :authenticate_employee!
  def index
    pagy, rewards = pagy(FilterRewards.new(Reward.order(created_at: :desc)
                                                 .includes(:category)).call(category), items: 3)
    render :index, locals: { rewards: rewards, pagy: pagy, categories: Category.order(title: :asc), category: category }
  end

  def show
    render :show, locals: { reward: reward }
  end

  private

  def reward
    @reward ||= Reward.find(params[:id])
  end

  def category
    @category = params[:category]
  end
end
