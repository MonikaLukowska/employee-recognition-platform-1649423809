require 'rails_helper'

RSpec.describe 'Admin kudos management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let!(:kudo) { create(:kudo) }

  before do
    driven_by(:selenium_chrome_headless)
    login_admin(admin_user)
    visit('/admin/dashboard')
  end

  it 'enables destroying the kudo' do
    click_link('Pages')
    click_link('Kudos')
    click_link('Destroy')
    page.accept_alert
    expect(page).to have_current_path(admin_users_kudos_path)
    expect(page).to have_text('Kudo was successfully destroyed')
  end
end
