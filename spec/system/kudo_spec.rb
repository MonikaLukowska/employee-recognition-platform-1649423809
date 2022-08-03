require 'rails_helper'

RSpec.describe 'Kudo management', type: :system do
  let(:employee) { create(:employee) }
  let!(:receiver) { create(:employee) }
  let!(:company_value) { create(:company_value) }

  before do
    login_employee(employee)
    visit root_path
  end

  context 'when creating new kudo' do
    let(:kudo) { build(:kudo) }

    it 'enables to give a kudo' do
      expect do
        click_link('New Kudo')
        fill_in('Title', with: kudo.title)
        fill_in('Content', with: kudo.content)
        click_button('Create Kudo')
      end.to change(Kudo, :count).by(1)
      expect(page).to have_current_path(kudos_path)
      expect(page).to have_text('Kudo was successfully created')
    end

    it 'prevents from creating a kudo without title' do
      expect do
        click_link('New Kudo')
        fill_in('Title', with: '')
        fill_in('Content', with: kudo.title)
        click_button('Create Kudo')
      end.to change(Kudo, :count).by(0)
      within('div#error_explanation') do
        expect(page).to have_text("Title can't be blank")
      end
    end

    it 'prevents from creating a kudo without content' do
      expect do
        click_link('New Kudo')
        fill_in('Title', with: kudo.title)
        fill_in('Content', with: '')
        click_button('Create Kudo')
      end.to change(Kudo, :count).by(0)
      within('div#error_explanation') do
        expect(page).to have_text("Content can't be blank")
      end
    end
  end

  context 'when kudo given by logged in employee exists' do
    let!(:kudo) { create(:kudo, giver: employee) }

    before do
      visit kudos_path
    end

    it 'shows kudo' do
      expect(page).to have_text(kudo.title)
      expect(page).to have_text(kudo.content)
      expect(page).to have_text(kudo.company_value.title)
    end

    it 'enables to edit the kudo' do
      expect(page).not_to have_link('Edit', class: 'disabled')
      click_link('Edit')
      fill_in('Title', with: 'Edited title')
      click_button('Update Kudo')
      expect(page).to have_current_path("/kudos/#{kudo.id}")
      expect(page).to have_text('Kudo was successfully updated')
    end

    it 'enables to destroy the kudo' do
      expect(page).not_to have_link('Destroy', class: 'disabled')
      click_link('Destroy')
      page.accept_alert
      expect(page).to have_current_path(kudos_path)
      expect(page).to have_text('Kudo was successfully destroyed')
      expect(Kudo.count).to eq 0
    end

    it 'prevents from removing kudo created more than 5 minutes ago' do
      travel 6.minutes
      page.refresh
      expect(page).to have_link('Destroy', class: 'disabled')
    end

    it 'prevents from editing kudo created more than 5 minutes ago' do
      travel 6.minutes
      visit('/kudos')
      expect(page).to have_link('Edit', class: 'disabled')
    end
  end

  context 'when kudo from other employee exists' do
    let!(:kudo) { create(:kudo) }

    before do
      visit kudos_path
    end

    it 'prevents from editing' do
      within("li#kudo_#{kudo.id}") do
        expect(page).to have_link('Edit', class: 'disabled')
      end
    end

    it 'prevents from destoying' do
      within("li#kudo_#{kudo.id}") do
        expect(page).to have_link('Destroy', class: 'disabled')
      end
    end
  end

  context 'when kudos are available' do
    let(:kudo) { build(:kudo) }

    before do
      visit root_path
    end

    it 'shows number of available kudos' do
      within('nav.navbar') do
        expect(page).to have_content("Available kudos: #{employee.number_of_available_kudos}")
      end
    end

    it 'decreases number after giving new kudo' do
      expect(employee.number_of_available_kudos).to eq 10
      click_link('New Kudo')
      fill_in('Title', with: kudo.title)
      fill_in('Content', with: kudo.content)
      click_button('Create Kudo')
      employee.reload
      expect(employee.number_of_available_kudos).to eq 9
      within('nav.navbar') do
        expect(page).to have_content("Available kudos: #{employee.number_of_available_kudos}")
      end
    end
  end

  context 'when there are no kudos left' do
    let(:kudo) { build(:kudo) }

    before do
      employee.update(number_of_available_kudos: 0)
      visit root_path
    end

    it 'prevents from giving a kudo' do
      expect do
        click_link('New Kudo')
        fill_in('Title', with: kudo.title)
        fill_in('Content', with: kudo.content)
        click_button('Create Kudo')
      end.to change(Kudo, :count).by(0)
      within('div#error_explanation') do
        expect(page).to have_text('You have no more avaialable kudos left')
      end
    end
  end
end
