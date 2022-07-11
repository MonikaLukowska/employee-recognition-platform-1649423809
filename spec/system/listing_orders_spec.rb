require 'rails_helper'

RSpec.describe 'Listing orders management', type: :system do
  let(:employee) { create(:employee) }
  let(:admin_user) { create(:admin_user) }
  let!(:kudo) { create(:kudo, receiver: employee) }
  let(:reward) { create(:reward) }
  let!(:order) { create(:order, employee: employee, reward: reward) }

  before do
    login_employee(employee)
    visit orders_path
  end

  it 'shows employee\'s orders list' do
    within("li[test_id='order_#{order.id}") do
      expect(page).to have_text(order.reward_snapshot.title)
      expect(page).to have_text(order.reward_snapshot.price)
      expect(page).to have_text(order.reward_snapshot.description)
      expect(page).to have_text(order.created_at.strftime('%d-%m-%Y'))
    end
  end

  it 'does not change order\'s reward price when admin edits reward\'s current price' do
    within('nav.navbar') do
      expect(page).to have_content('Earned points: 0')
    end
    using_session('Admin') do
      login_admin(admin_user)

      visit('/admin/rewards')

      click_on 'Edit'
      fill_in('Price', with: 2.0)
      click_button('Update Reward')
      reward.reload
    end

    refresh

    click_on 'Rewards'
    within("li[test_id='reward_#{reward.id}") do
      expect(page).to have_text('Price: 2.0')
    end

    click_on 'Orders'
    within('nav.navbar') do
      expect(page).to have_content('Earned points: 0')
    end
    within("li[test_id='order_#{order.id}") do
      expect(page).to have_text('Reward price: 1.0')
    end
  end
end
