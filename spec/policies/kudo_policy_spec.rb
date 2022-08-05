require 'rails_helper'

describe KudoPolicy do
  subject(:kudo_policy) { described_class }

  let!(:employee) { create(:employee) }
  let!(:kudo) { create(:kudo, giver: employee) }

  permissions :update?, :edit? do
    it 'grants access if kudo was created less than 5 minutes ago' do
      expect(kudo_policy).to permit(employee, kudo)
    end

    it 'denies access if kudo was created later than 5 minutes ago' do
      travel 6.minutes
      expect(kudo_policy).not_to permit(employee, kudo)
    end
  end
end
