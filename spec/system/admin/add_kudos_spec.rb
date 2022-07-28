require 'rails_helper'

RSpec.describe 'Admin adding kudos management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let!(:employee1) { create(:employee, number_of_available_kudos: 2) }
  let!(:employee2) { create(:employee, number_of_available_kudos: 3) }
  let!(:employee3) { create(:employee, number_of_available_kudos: 4) }

  before do
    login_admin(admin_user)
    visit('/admin/dashboard')
  end

  it 'enables increasing available kudos for all employees' do
    click_link('Add kudos')
    expect(page).to have_current_path(add_kudos_admin_users_employees_path)
    expect(page).to have_text('Edit number of available kudos')

    fill_in('Number of kudos', with: 5)
    click_button('Add kudos')
    page.accept_alert
    expect(page).to have_current_path(admin_users_employees_path)
    expect(page).to have_text('Numbers of available kudos where increased succesfully')
    within("li[test_id='employee_#{employee1.id}") do
      expect(page).to have_content('Number of kudos: 7')
    end
    within("li[test_id='employee_#{employee2.id}") do
      expect(page).to have_content('Number of kudos: 8')
    end
    within("li[test_id='employee_#{employee3.id}") do
      expect(page).to have_content('Number of kudos: 9')
    end
  end
end
