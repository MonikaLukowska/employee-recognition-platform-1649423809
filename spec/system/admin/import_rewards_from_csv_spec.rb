require 'rails_helper'

RSpec.describe 'Import rewards from csv', type: :system do
  let(:admin_user) { create(:admin_user) }
  let(:category) { create(:category, title: 'Category 1') }
  let!(:reward) { create(:reward, title: 'First reward', price: 1.0, category: category) }

  before do
    login_admin(admin_user)
    visit('/admin/rewards')
  end

  context 'when importing rewards from CSV' do
    it 'updates rewards and import new form uploaded file' do
      click_link 'Import Rewards'
      attach_file(File.absolute_path('./spec/fixtures/no_error.csv'))
      click_button 'Import rewards'
      within('div.alert') do
        expect(page).to have_content('Rewards imported successfully')
      end
      expect(page).to have_content('Title: New reward')
      within("[test_id='reward_#{reward.id}']") do
        expect(page).to have_content('Price: 2.0')
        expect(page).to have_content('Description: New Description')
      end
    end

    it 'aborts import when titles are not unique' do
      click_link 'Import Rewards'
      attach_file(File.absolute_path('./spec/fixtures/title_err.csv'))
      click_button 'Import rewards'
      within('div.alert') do
        expect(page).to have_content(
          'Duplicated titles detected: Title 1,Title 1'
        )
      end
      expect(page).not_to have_content('Title: New Reward')
    end

    it 'aborts import when category does not exist' do
      click_link 'Import Rewards'
      attach_file(File.absolute_path('./spec/fixtures/cat_err.csv'))
      click_button 'Import rewards'
      within('div.alert') do
        expect(page).to have_content(
          "Category 'Category 4' does not exist"
        )
      end
      expect(page).not_to have_content('Title: New Reward')
    end

    it 'aborts import when file format is not .csv' do
      click_link 'Import Rewards'
      attach_file(File.absolute_path('./spec/fixtures/sample.pdf'))
      click_button 'Import rewards'
      within('div.alert') do
        expect(page).to have_content('Invalid file format')
      end
    end
  end
end
