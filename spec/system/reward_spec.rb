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

  context 'when there are no more than 3 rewards' do
    it 'there is no active next page link nor page 2 link' do
      visit rewards_path
      within('nav.pagy-bootstrap-nav') do
        expect(page).to have_css('li.disabled', text: 'Next')
        expect(page).not_to have_link('2')
      end
    end
  end

  context 'when there are more than 3 rewards' do
    it 'shows 3 rewards per page only' do
      rewards = create_list(:reward, 3)
      visit rewards_path

      expect(page).to have_content(rewards.last.title)
      expect(page).to have_content(rewards.first.title)
      expect(page).to have_content(rewards[1].title)
      expect(page).not_to have_content(reward.title)
      within('nav.pagy-bootstrap-nav') do
        expect(page).to have_link('2')
      end

      click_link('2')
      expect(page).to have_current_path('/rewards?page=2')
      expect(page).to have_content(reward.title)
      click_link('1')
      expect(page).to have_current_path('/rewards?page=1')
    end
  end
end
