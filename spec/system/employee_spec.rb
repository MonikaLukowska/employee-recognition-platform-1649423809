require 'rails_helper'

RSpec.describe 'Employee management', type: :system do
  before do
    visit('/')
  end

  let(:employee) { build(:employee) }

  it 'enables signing up' do
    expect do
      first(:link, 'Sign up').click
      fill_in('Email', with: employee.email)
      fill_in('Password', with: employee.password)
      fill_in('Password confirmation', with: employee.password)
      click_button('Sign up')
    end.to change(Employee, :count).by(1)
    expect(page).to have_text('Welcome! You have signed up successfully.')
    expect(page).to have_current_path(root_path)
  end

  it 'enables signing in' do
    employee.save
    fill_in('Email', with: employee.email)
    fill_in('Password', with: employee.password)
    click_button('Log in')
    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_current_path(root_path)
  end
end
