require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  let(:employee) { create(:employee) }

  before do
    driven_by(:selenium_chrome_headless)
    login employee
    visit root_path
  end

  context 'when creating new kudo' do
    let(:kudo) { build(:kudo) }

    it 'can give a kudo' do
      expect do
        click_link('New Kudo')
        fill_in('Title', with: kudo.title)
        fill_in('Content', with: kudo.content)
        select(kudo.receiver.id, from: 'kudo[receiver_id]')
        click_button('Create Kudo')
      end.to change(Kudo, :count).by(1)
      expect(page).to have_current_path(kudos_path)
      expect(page).to have_text('Kudo was successfully created')
    end

    it 'cannot create a kudo without title' do
      expect do
        click_link('New Kudo')
        fill_in('Title', with: '')
        fill_in('Content', with: kudo.title)
        select(kudo.receiver.id, from: 'kudo[receiver_id]')
        click_button('Create Kudo')
      end.to change(Kudo, :count).by(0)
      within('div#error_explanation') do
        expect(page).to have_text("Title can't be blank")
      end
    end

    it 'cannot create a kudo without content field' do
      expect do
        click_link('New Kudo')
        fill_in('Title', with: kudo.title)
        fill_in('Content', with: '')
        select(kudo.receiver.id, from: 'kudo[receiver_id]')
        click_button('Create Kudo')
      end.to change(Kudo, :count).by(0)
      within('div#error_explanation') do
        expect(page).to have_text("Content can't be blank")
      end
    end
  end

  context 'when kudo given by logged in employee exists' do
    let(:kudo) { create(:kudo, giver: employee) }

    before do
      kudo
      visit kudos_path
    end

    it 'shows kudo' do
      expect(page).to have_text(kudo.title)
      expect(page).to have_text(kudo.content)
    end

    it 'can edit kudo' do
      click_link('Edit')
      fill_in('Title', with: 'Edited title')
      click_button('Update Kudo')
      expect(page).to have_current_path("/kudos/#{kudo.id}")
      expect(page).to have_text('Kudo was successfully updated')
    end

    it 'can delete kudo' do
      visit('/kudos')
      click_link('Destroy')
      page.accept_alert
      expect(page).to have_current_path(kudos_path)
      expect(page).to have_text('Kudo was successfully destroyed')
    end
  end

  context 'when kudo from other employee exists' do
    let(:kudo) { create(:kudo) }

    before do
      kudo
      visit kudos_path
    end

    it 'prevents from editing' do
      within("tr#kudo_#{kudo.id}") do
        expect(page).to have_no_link('Edit')
      end
    end

    it 'prevents from destoying' do
      within("tr#kudo_#{kudo.id}") do
        expect(page).to have_no_link('Destroy')
      end
    end
  end
end