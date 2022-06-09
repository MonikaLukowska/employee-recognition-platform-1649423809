require 'rails_helper'

RSpec.describe 'Admin management', type: :system do
  before do
    visit('/admin')
  end

  let(:admin_user) { create(:admin_user) }

  it 'enables signing in' do
    fill_in('Email', with: admin_user.email)
    fill_in('Password', with: admin_user.password)
    click_button('Log in')
    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_current_path(admin_users_dashboard_path)
  end
end
