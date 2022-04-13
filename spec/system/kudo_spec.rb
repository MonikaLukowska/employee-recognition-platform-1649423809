require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'enables employess to give a new kudo' do
    employee = create(:employee)
    login_as(employee, scope: :employee)
    visit('/kudos')
    click_link('New Kudo')
    fill_in('Title', with: 'Test Kudo')
    fill_in('Content', with: 'Test Kudo Content')
    option = first('#kudo_receiver_id option').text
    select(option, from: 'kudo[receiver_id]')
    click_button('Create Kudo')
    expect(page).to have_current_path(kudos_path)
    expect(page).to have_text('Kudo was successfully created')
  end

  context 'when exists kudo given by logged in user' do
    it 'enables employee edit kudo he has given' do
      employee = create(:employee)
      login_as(employee, scope: :employee)
      kudo = Kudo.create!(title: 'New kudo', content: 'New kudo content', receiver: employee, giver: employee)
      visit('/kudos')
      click_link('Edit')
      fill_in('Title', with: 'Edited title')
      click_button('Update Kudo')
      expect(page).to have_current_path("/kudos/#{kudo.id}")
      expect(page).to have_text('Kudo was successfully updated')
    end

    it 'enables employee delete kudo he has given' do
      employee = create(:employee)
      login_as(employee, scope: :employee)
      Kudo.create!(title: 'New kudo', content: 'New kudo content', receiver: employee, giver: employee)
      visit('/kudos')
      click_link('Destroy')
      page.accept_alert
      expect(page).to have_current_path(kudos_path)
      expect(page).to have_text('Kudo was successfully destroyed')
    end
  end
end
