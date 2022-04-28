require 'rails_helper'

RSpec.describe 'Admin company values management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let!(:company_value) { create(:company_value) }

  before do
    driven_by(:selenium_chrome_headless)
    login_admin(admin_user)
    visit('/admin/dashboard')
  end

  it 'shows company values list' do
    click_link('Company values')
    expect(page).to have_current_path(admin_users_company_values_path)
    expect(page).to have_css("#company_value_#{company_value.id}")
  end

  context 'when on employess list page' do
    before do
      visit('/admin/company_values')
    end

    it 'enables editing a company values' do
      click_link('Edit')
      fill_in('Title', with: 'Updated title')
      click_button('Update Company value')
      expect(page).to have_content('Company Value was successfully updated')
      expect(page).to have_current_path(admin_users_company_values_path)
      within("li#company_value_#{company_value.id}") do
        expect(page).to have_content('Updated title')
      end
    end

    it 'enables removing a company value' do
      click_link('Remove')
      page.accept_alert
      expect(page).to have_content('Company Value was successfully destroyed')
      expect(page).to have_current_path(admin_users_company_values_path)
    end
  end
end
