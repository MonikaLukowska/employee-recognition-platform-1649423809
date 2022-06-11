require 'rails_helper'

RSpec.describe 'Earned points management', type: :system do
  let(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, receiver: employee) }

  before do
    login_employee(employee)
    visit root_path
  end

  it 'shows number of earned points in navbar' do
    within('nav.navbar') do
      expect(page).to have_content("Earned points: #{employee.earned_points}")
    end
  end

  it 'changes number of earned points after destroying kudo' do
    expect(employee.earned_points).to eq 1
    kudo.destroy
    visit root_path
    expect(employee.earned_points).to eq 0
    within('nav.navbar') do
      expect(page).to have_content("Earned points: #{employee.earned_points}")
    end
  end
end
