class DeliveryConfirmationMailer < ActionMailer::Preview
  def order_delivery_confirmation_email
    DeliveryConfirmationMailer.with(order: FactoryBot.build(:order))
                              .order_delivery_confirmation_email(FactoryBot.build(:order))
  end
end
