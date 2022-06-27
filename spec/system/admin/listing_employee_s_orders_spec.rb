require 'rails_helper'

RSpec.describe 'Employee\'s orders management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let(:employee) { create(:employee) }
  let!(:order) { create(:order, employee: employee) }

  before do
    login_admin(admin_user)
    visit('/admin/employees')
  end

  it 'can go to employee\'s orders listing page' do
    within("li[test_id='employee_#{employee.id}") do
      expect(page).to have_link("Employee's orders")
    end
    click_on 'Employee\'s orders'
    expect(page).to have_current_path(admin_users_employee_orders_path(employee))
    within("li[test_id='order_#{order.id}") do
      expect(page).to have_content(order.purchase_price)
      expect(page).to have_text(order.reward_snapshot.title)
      expect(page).to have_text(order.reward_snapshot.description)
      expect(page).to have_text(order.created_at.strftime('%d-%m-%Y'))
    end
  end
end
