require 'rails_helper'

RSpec.describe CompanyValue, type: :model do
  context 'when creating new company value' do
    before do
      create(:company_value)
    end

    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  end
end
