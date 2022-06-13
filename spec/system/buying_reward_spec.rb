require 'rails_helper'

RSpec.describe 'Buying reward management', type: :system do
  let(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, receiver: employee) }
  let!(:reward) { create(:reward, price: 1) }

  before do
    login_employee(employee)
    visit rewards_path
  end

  it 'lowers number of earned points after buying a reward' do
    expect(employee.earned_points).to eq 1
    click_link('Buy now')
    expect(page).to have_text('You have successfully bought new reward.')
    expect(employee.earned_points).to eq 0
    within('nav.navbar') do
      expect(page).to have_content("Earned points: #{employee.earned_points}")
    end
  end
end
