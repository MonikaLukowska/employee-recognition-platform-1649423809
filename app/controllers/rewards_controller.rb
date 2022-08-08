class RewardsController < ApplicationController
  before_action :authenticate_employee!
  REWARDS_PER_PAGE = 3

  def index
    render :index, locals: { rewards: Reward.order(created_at: :desc).paginate(page, REWARDS_PER_PAGE),
                             pagination_result: pagination_result, current_page: page }
  end

  def show
    render :show, locals: { reward: reward }
  end

  private

  def reward
    @reward ||= Reward.find(params[:id])
  end

  def page
    @page = params[:page].present? ? params[:page].to_i : 1
  end

  def pagination_result
    @pagination_result ||= (Reward.count / REWARDS_PER_PAGE.to_f).ceil
  end
end
