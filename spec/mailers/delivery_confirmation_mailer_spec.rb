require 'rails_helper'

RSpec.describe DeliveryConfirmationMailer, type: :mailer do
  describe 'confirm order delivery' do
    let(:order) { create(:order) }
    let(:email) { described_class.order_delivery_confirmation_email(order).deliver_now }

    it 'renders the subject' do
      expect(email.subject).to eq('Congrats, Your reward is has been delivered!')
    end

    it 'renders the receiver email' do
      expect(email.to).to eq([order.employee.email])
    end

    it 'renders the sender email' do
      expect(email.from).to eq([Rails.application.credentials.dig(:sendgrid, :from_email)])
    end

    it 'renders the body' do
      expect(email.body.encoded).to have_content order.reward_snapshot.title
      expect(email.body.encoded).to have_content order.reward_snapshot.description
      expect(email.body.encoded).to have_content order.reward_snapshot.price
    end
  end
end
