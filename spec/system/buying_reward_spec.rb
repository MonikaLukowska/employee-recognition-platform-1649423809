require 'rails_helper'

RSpec.describe 'Buying reward management', type: :system do
  let(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, receiver: employee) }
  let!(:reward) { create(:reward, price: 1) }
  let!(:expensive_reward) { create(:reward, price: 2) }

  before do
    login_employee(employee)
    visit rewards_path
  end

  it 'lowers number of earned points after buying a reward' do
    expect(employee.earned_points).to eq 1
    click_button('Buy now')
    expect(page).to have_text('You have successfully bought new reward.')
    employee.reload
    expect(employee.earned_points).to eq 0
    within('nav.navbar') do
      expect(page).to have_content("Earned points: #{employee.earned_points}")
    end
  end

  it 'prevents form buying a reward employee cannot afford' do
    within("li[test_id='reward_#{expensive_reward.id}") do
      expect(page).to have_button('Buy now', disabled: true)
    end
  end
end
