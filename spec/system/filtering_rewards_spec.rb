require 'rails_helper'

RSpec.describe 'Filtering rewards management', type: :system do
  let(:employee) { create(:employee) }
  let(:category1) { create(:category) }
  let(:category2) { create(:category) }
  let!(:reward1) { create(:reward, category: category1) }
  let!(:reward2) { create(:reward, category: category2) }

  before do
    login_employee(employee)
    visit root_path
  end

  it 'filters rewards by category' do
    click_link('Rewards')
    active = find(:css, '.bg-warning')

    expect(active).to have_link('All')
    expect(page).to have_link(category1.title)
    expect(page).to have_link(category2.title)
    expect(page).to have_content(reward1.title)
    expect(page).to have_content(reward2.title)

    click_link(category1.title)
    expect(active).to have_link(category1.title)
    expect(page).not_to have_css("li[test_id='reward_#{reward2.id}")
    expect(page).to have_css("li[test_id='reward_#{reward1.id}")

    click_link(category2.title)
    expect(active).to have_link(category2.title)
    expect(page).to have_css("li[test_id='reward_#{reward2.id}")
    expect(page).not_to have_css("li[test_id='reward_#{reward1.id}")

    click_link('All')
    expect(active).to have_link('All')
    expect(page).to have_css("li[test_id='reward_#{reward1.id}")
    expect(page).to have_css("li[test_id='reward_#{reward2.id}")
  end
end
