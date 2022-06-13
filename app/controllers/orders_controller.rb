class OrdersController < ApplicationController
  before_action :authenticate_employee!
  def create
    if current_employee.earned_points < reward.price
      redirect_to rewards_path, notice: 'You do not have enough points to buy this reward.'
    else
      order = Order.new(employee: current_employee, reward: reward)
      if order.save
        redirect_to rewards_path, notice: 'You have successfully bought new reward.'
      else
        redirect_to rewards_path, notice: 'Something went wrong.'
      end
    end
  end

  private

  def reward
    Reward.find(params[:reward])
  end
end
