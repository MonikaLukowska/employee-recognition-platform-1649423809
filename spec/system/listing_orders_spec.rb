require 'rails_helper'

RSpec.describe 'Listing orders management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let!(:order) { create(:order) }

  before do
    login_employee(order.employee)
    visit orders_path
  end

  context 'when listing orders' do
    let(:order_delivered) { create(:order, employee: order.employee, status: 1) }

    it 'shows employee\'s orders list' do
      visit orders_path
      within("li[test_id='order_#{order.id}") do
        expect(page).to have_text(order.reward_snapshot.title)
        expect(page).to have_text(order.reward_snapshot.price)
        expect(page).to have_text(order.reward_snapshot.description)
        expect(page).to have_text(order.created_at.strftime('%d-%m-%Y'))
      end
    end

    it 'enables filtering orders' do
      expect(page).to have_link('All orders')
      expect(page).to have_link('Delivered')
      expect(page).to have_link('Not delivered')
      order_delivered

      click_on 'Delivered'
      expect(page).to have_css("li[test_id='order_#{order_delivered.id}")
      expect(page).not_to have_css("li[test_id='order_#{order.id}")

      click_on 'Not delivered'
      expect(page).not_to have_css("li[test_id='order_#{order_delivered.id}")
      expect(page).to have_css("li[test_id='order_#{order.id}")

      click_on 'All orders'
      expect(page).to have_css("li[test_id='order_#{order_delivered.id}")
      expect(page).to have_css("li[test_id='order_#{order.id}")
    end
  end

  context 'when editing order price' do
    it 'does not change order\'s reward price when admin edits reward\'s current price' do
      using_session('Admin') do
        login_admin(admin_user)

        visit('/admin/rewards')

        click_on 'Edit'
        fill_in('Price', with: 2.0)
        click_button('Update Reward')
        order.reward.reload
      end

      refresh

      click_on 'Rewards'
      within("li[test_id='reward_#{order.reward.id}") do
        expect(page).to have_text('Price: 2.0')
      end

      click_on 'Orders'
      within("li[test_id='order_#{order.id}") do
        expect(page).to have_text('Reward price: 1.0')
      end
    end
  end
end
