require 'rails_helper'

RSpec.describe 'Admin rewards management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let!(:reward) { create(:reward) }

  before do
    login_admin(admin_user)
    visit('/admin/dashboard')
  end

  it 'can go to rewards listing page' do
    click_link('Rewards')
    expect(page).to have_current_path(admin_users_rewards_path)
    expect(page).to have_content(reward.title)
    expect(page).to have_content(reward.description)
    expect(page).to have_selector(:css, "li[test_id='reward_#{reward.id}']")
  end

  context 'when visiting rewards listing page' do
    let(:new_reward) { build(:reward) }

    before do
      visit('/admin/rewards')
    end

    it 'enables editing rewards' do
      click_link('Edit')
      fill_in('Title', with: new_reward.title)
      fill_in('Description', with: new_reward.description)
      fill_in('Price', with: 2)
      click_button('Update Reward')
      expect(page).to have_content('Reward was successfully updated')
      expect(page).to have_current_path(admin_users_rewards_path)
      expect(page).to have_content(new_reward.title)
      expect(page).to have_content(new_reward.description)
      expect(page).to have_content('2')
    end

    it 'enables removing reward' do
      click_link('Remove')
      page.accept_alert
      expect(page).to have_content('Reward was successfully destroyed')
      expect(page).to have_current_path(admin_users_rewards_path)
      expect(Reward.count).to eq 0
    end

    it 'enables creating new reward' do
      click_link('New Reward')
      fill_in('Title', with: new_reward.title)
      fill_in('Description', with: new_reward.description)
      fill_in('Price', with: 2)
      click_button('Create Reward')
      expect(page).to have_content('Reward was successfully created')
      expect(page).to have_content(new_reward.title)
      expect(page).to have_content(new_reward.description)
      expect(page).to have_content('2')
      expect(Reward.count).to eq 2
    end

    it 'prevents from creating reward without title' do
      click_link('New Reward')
      fill_in('Description', with: new_reward.description)
      fill_in('Price', with: 2)
      click_button('Create Reward')
      expect(Reward.count).to eq 1
      within('div#error_explanation') do
        expect(page).to have_content("Title can't be blank")
      end
    end

    it 'prevents from creating reward without description' do
      click_link('New Reward')
      fill_in('Title', with: new_reward.title)
      fill_in('Price', with: 2)
      click_button('Create Reward')
      expect(Reward.count).to eq 1
      within('div#error_explanation') do
        expect(page).to have_content("Description can't be blank")
      end
    end

    it 'prevents from creating reward without price' do
      click_link('New Reward')
      fill_in('Title', with: new_reward.title)
      fill_in('Description', with: new_reward.description)
      click_button('Create Reward')
      expect(Reward.count).to eq 1
      within('div#error_explanation') do
        expect(page).to have_content("Price can't be blank")
      end
    end

    it 'prevents from creating reward with price lower than 1' do
      click_link('New Reward')
      fill_in('Title', with: new_reward.title)
      fill_in('Description', with: new_reward.description)
      fill_in('Price', with: '0.5')
      click_button('Create Reward')
      expect(Reward.count).to eq 1
      within('div#error_explanation') do
        expect(page).to have_content('Price must be greater than or equal to 1')
      end
    end
  end
end
