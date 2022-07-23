class DeliveryConfirmationMailer < ApplicationMailer
  def order_delivery_confirmation_email(order)
    @employee = order.employee
    @reward = order.reward_snapshot
    mail(
      to: @employee.email,
      subject: 'Congrats, Your reward is has been delivered!'
    )
  end
end
