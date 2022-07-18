class OrdersController < ApplicationController
  before_action :authenticate_employee!
  def index
    render :index, locals: { orders: Order.of_an_employee(current_employee).filtered_by_status(status) }
  end

  def create
    if current_employee.earned_points < reward.price
      redirect_to rewards_path, notice: 'You do not have enough points to buy this reward.'
    else
      order = Order.new(employee: current_employee, reward: reward, reward_snapshot: reward)
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

  def status
    @status = params[:status]
  end
end
