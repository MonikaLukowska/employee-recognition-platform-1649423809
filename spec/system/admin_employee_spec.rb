require 'rails_helper'

RSpec.describe 'Admin kudos management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let(:employee) { create(:employee) }

  before do
    driven_by(:selenium_chrome_headless)
    login_admin admin_user
    visit('/admin/dashboard')
    employee
  end

  it 'can see employees list' do
    click_link('Employees list')
    expect(page).to have_current_path(admin_users_employees_path)
    expect(page).to have_css("#employee_#{employee.id}")
  end

  context 'when on employess list page' do
    before do
      visit('/admin/employees')
    end

    it 'can edit employee' do
      click_link('Edit')
      fill_in('Number of available kudos', with: 9)
      click_button('Update Employee')
      expect(page).to have_content('Employee was successfully updated')
      expect(page).to have_current_path(admin_users_employees_path)
      within("li#employee_#{employee.id}") do
        expect(page).to have_content('Number of kudos: 9')
      end
    end

    it 'can remove employee' do
      click_link('Remove')
      page.accept_alert
      expect(page).to have_content('Employee was successfully destroyed')
      expect(page).to have_current_path(admin_users_employees_path)
    end
  end
end
