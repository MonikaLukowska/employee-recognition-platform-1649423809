require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  let(:employee) { create(:employee) }
  let(:kudo) { create(:kudo, giver: employee) }

  before do
    driven_by(:selenium_chrome_headless)
    login employee
    visit root_path
  end

  it 'enables employess to give a new kudo' do
    expect do
      click_link('New Kudo')
      fill_in('Title', with: 'Test Kudo')
      fill_in('Content', with: 'Test Kudo Content')
      option = first('#kudo_receiver_id option').text
      select(option, from: 'kudo[receiver_id]')
      click_button('Create Kudo')
    end.to change(Kudo, :count).by(1)
    expect(page).to have_current_path(kudos_path)
    expect(page).to have_text('Kudo was successfully created')
  end

  it 'prevents from creating kudo without title field' do
    expect do
      click_link('New Kudo')
      fill_in('Title', with: '')
      fill_in('Content', with: 'Test Kudo Content')
      option = first('#kudo_receiver_id option').text
      select(option, from: 'kudo[receiver_id]')
      click_button('Create Kudo')
    end.to change(Kudo, :count).by(0)
    within('div#error_explanation') do
      expect(page).to have_text("Title can't be blank")
    end
  end

  it 'prevents from creating kudo without content field' do
    expect do
      click_link('New Kudo')
      fill_in('Title', with: 'Test kudo')
      fill_in('Content', with: '')
      option = first('#kudo_receiver_id option').text
      select(option, from: 'kudo[receiver_id]')
      click_button('Create Kudo')
    end.to change(Kudo, :count).by(0)
    within('div#error_explanation') do
      expect(page).to have_text("Content can't be blank")
    end
  end

  context 'when kudo given by logged in employee exists' do
    before do
      kudo
      visit kudos_path
    end

    it 'shows kudo on the list' do
      expect(page).to have_text(kudo.title)
      expect(page).to have_text(kudo.content)
    end

    it 'enables employee edit kudo he has given' do
      click_link('Edit')
      fill_in('Title', with: 'Edited title')
      click_button('Update Kudo')
      expect(page).to have_current_path("/kudos/#{kudo.id}")
      expect(page).to have_text('Kudo was successfully updated')
    end

    it 'enables employee delete kudo he has given' do
      visit('/kudos')
      click_link('Destroy')
      page.accept_alert
      expect(page).to have_current_path(kudos_path)
      expect(page).to have_text('Kudo was successfully destroyed')
    end
  end

  context 'when kudo from other employee exists' do
    let(:other_employee) { create(:employee, email: 'other@employee.com', password: '1234456') }
    let(:other_emp_kudo) { create(:kudo, giver: other_employee) }

    before do
      other_emp_kudo
      visit kudos_path
    end

    it 'prevents from editing other employee kudos' do
      within("tr#kudo_#{other_emp_kudo.id}") do
        expect(page).to have_no_link('Edit')
      end
    end

    it 'prevents from destoying other employee kudos' do
      within("tr#kudo_#{other_emp_kudo.id}") do
        expect(page).to have_no_link('Destroy')
      end
    end
  end
end
