require 'rails_helper'

RSpec.describe 'Reward management', type: :system do
  let(:employee) { create(:employee) }
  let!(:reward) { create(:reward) }

  before do
    login_employee(employee)
    visit root_path
  end

  it 'enables to see list of available rewards' do
    click_link('Rewards')
    expect(page).to have_current_path(rewards_path)
    within("[test_id='reward_#{reward.id}']") do
      expect(page).to have_content(reward.title)
      expect(page).to have_content(reward.price)
    end
  end

  it 'enables to see reward details' do
    visit rewards_path
    click_link('Show')
    expect(page).to have_current_path(reward_path(reward.id))
    expect(page).to have_content(reward.title)
    expect(page).to have_content(reward.description)
    expect(page).to have_content(reward.price)
  end
end
