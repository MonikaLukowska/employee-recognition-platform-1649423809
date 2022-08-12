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
      reward2 = create(:reward)
      reward3 = create(:reward)
      reward4 = create(:reward)
      visit rewards_path

      expect(page).to have_content(reward4.title)
      expect(page).to have_content(reward3.title)
      expect(page).to have_content(reward2.title)
      expect(page).not_to have_content(reward.title)
      within('nav.pagy-bootstrap-nav') do
        expect(page).to have_link('2')
      end

      within('nav.pagy-bootstrap-nav') do
        click_link('2')
      end

      expect(page).to have_content(reward.title)
      expect(page).not_to have_content(reward2.title)

      within('nav.pagy-bootstrap-nav') do
        click_link('1')
      end

      expect(page).to have_content(reward4.title)
      expect(page).to have_content(reward3.title)
      expect(page).to have_content(reward2.title)
      expect(page).not_to have_content(reward.title)
    end
  end
end
