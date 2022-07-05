require 'rails_helper'

RSpec.describe 'Order delivery management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let(:employee) { create(:employee) }
  let!(:order) { create(:order, employee: employee) }

  before do
    login_admin(admin_user)
    visit('/admin/employees')
  end

  it 'can see the number of undelivered orders' do
    within("li[test_id='employee_#{employee.id}") do
      expect(page).to have_link("Employee's orders (1)")
    end
  end

  it 'can deliver order only once' do
    click_link("Employee's orders (1)")
    expect(page).to have_current_path(admin_users_employee_orders_path(employee))

    within("li[test_id='order_#{order.id}") do
      expect(page).to have_button('Deliver')
    end

    click_button('Deliver')
    page.accept_alert
    expect(page).to have_current_path(admin_users_employee_orders_path(employee))
    expect(page).to have_text('Order has been delivered')

    order.reload
    expect(order.status).to eq 'delivered'
    within("li[test_id='order_#{order.id}") do
      expect(page).to have_button('Deliver', disabled: true)
    end
  end
end
