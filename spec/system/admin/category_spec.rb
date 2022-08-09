require 'rails_helper'

RSpec.describe 'Admin categories management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let!(:category) { create(:category) }

  before do
    login_admin(admin_user)
    visit('/admin/dashboard')
  end

  context 'when adding new category' do
    let(:new_category) { build(:category) }

    before do
      click_link('Categories')
    end

    it 'creates new category' do
      click_link('New category')
      fill_in('Title', with: new_category.title)
      click_button('Create Category')
      within('p.notice') do
        expect(page).to have_content('Category was successfully created')
      end
      expect(page).to have_content(new_category.title)
      expect(Category.count).to eq 2
    end

    it 'prevents form creating category with duplicated title' do
      click_link('New category')
      fill_in('Title', with: category.title)
      click_button('Create Category')
      within('div#error_explanation') do
        expect(page).to have_content('Title has already been taken')
      end
      expect(Category.count).to eq 1
    end

    it 'prevents form creating category without title' do
      click_link('New category')
      click_button('Create Category')
      within('div#error_explanation') do
        expect(page).to have_content('Title can\'t be blank')
      end
      expect(Category.count).to eq 1
    end

    it 'enables editing category' do
      click_link('Edit')
      fill_in('Title', with: new_category.title)
      click_button('Update Category')
      within('p.notice') do
        expect(page).to have_content('Category was successfully updated')
      end
      expect(page).to have_current_path(admin_users_categories_path)
      expect(page).to have_content(new_category.title)
    end

    it 'removes category when it\'s not assigned to any reward' do
      click_link('Remove')
      page.accept_alert
      expect(page).to have_content('Category was successfully destroyed')
      expect(page).to have_current_path(admin_users_categories_path)
      expect(Category.count).to eq 0
    end
  end

  context 'when assigining category to the reward' do
    let!(:reward) { create(:reward) }

    it 'adds category to the reward' do
      click_link('Rewards')
      click_link('Edit')
      select category.title
      click_button('Update Reward')
      within("li[test_id='reward_#{reward.id}']") do
        expect(page).to have_content("Category: #{category.title}")
      end
    end

    it 'removes category from reward' do
      reward.update(category: category)
      click_link('Rewards')
      click_link('Edit')
      select 'No category'
      click_button('Update Reward')
      within("li[test_id='reward_#{reward.id}']") do
        expect(page).to have_content('Category: No category')
      end
      reward.reload
      expect(reward.category).not_to be_present
    end

    it 'prevents form removing category assigned to the reward' do
      reward.update(category: category)
      click_link('Categories')
      click_link('Remove')
      page.accept_alert
      within('p.notice') do
        expect(page).to have_content('This category has related rewards and cannot be destroyed')
      end
      expect(page).to have_current_path(admin_users_categories_path)
      within("li[test_id='category_#{category.id}']") do
        expect(page).to have_content(category.title)
      end
      expect(Category.count).to eq 1
    end
  end
end
