require 'rails_helper'
require 'csv'

RSpec.describe 'Export orders to csv', type: :system do
  let(:admin_user) { create(:admin_user) }
  let!(:order) { create(:order) }

  before do
    driven_by(:rack_test)
    login_admin(admin_user)
    visit('/admin')
  end

  it 'generates CSV file with orders' do
    click_link('Export orders')

    csv = CSV.parse(page.body)

    headers = %w[Date Email Title Description Price Status]

    expect(csv).to have_content(headers)
    expect(csv).to have_content(order.created_at.strftime('%d-%m-%Y'))
    expect(csv).to have_content(order.employee.email)
    expect(csv).to have_content(order.reward_snapshot.title)
    expect(csv).to have_content(order.reward_snapshot.description)
    expect(csv).to have_content(order.reward_snapshot.price)
    expect(csv).to have_content(order.status)
  end
end
