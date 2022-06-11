require 'rails_helper'

RSpec.describe 'Admin company values management', type: :system do
  let(:admin_user) { create(:admin_user) }
  let!(:company_value) { create(:company_value) }

  before do
    login_admin(admin_user)
    visit('/admin/dashboard')
  end

  it 'shows company values list' do
    click_link('Company values')
    expect(page).to have_current_path(admin_users_company_values_path)
    expect(page).to have_content(company_value.title)
  end

  context 'when on company values listing page' do
    before do
      visit('/admin/company_values')
    end

    it 'enables editing a company values' do
      click_link('Edit')
      fill_in('Title', with: 'Updated title')
      click_button('Update Company value')
      expect(page).to have_content('Company value was successfully updated')
      expect(page).to have_current_path(admin_users_company_values_path)
      within("li#company_value_#{company_value.id}") do
        expect(page).to have_content('Updated title')
      end
    end

    it 'enables removing a company value' do
      click_link('Remove')
      page.accept_alert
      expect(page).to have_content('Company value was successfully destroyed')
      expect(page).to have_current_path(admin_users_company_values_path)
      expect(CompanyValue.count).to eq 0
    end

    it 'enables creating new company value' do
      click_link('New Company value')
      fill_in('Title', with: 'New Company Value')
      click_button('Create Company value')
      expect(CompanyValue.count).to eq 2
      expect(page).to have_content('Company value was successfully created')
      expect(page).to have_content('New Company Value')
    end

    it 'prevents from duplicating company value title' do
      click_link('New Company value')
      fill_in('Title', with: company_value.title)
      click_button('Create Company value')
      expect(CompanyValue.count).to eq 1
      within('div#error_explanation') do
        expect(page).to have_content('Title has already been taken')
      end
    end

    it 'prevents from creating company value without title' do
      click_link('New Company value')
      fill_in('Title', with: '')
      click_button('Create Company value')
      expect(CompanyValue.count).to eq 1
      within('div#error_explanation') do
        expect(page).to have_content("Title can't be blank")
      end
    end
  end
end
