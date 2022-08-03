class KudoPolicy < ApplicationPolicy
  attr_accessor :error_message

  def update?
    true if not_too_late? && same_kudo_giver?
  end

  def destroy?
    update?
  end

  private

  def not_too_late?
    record.created_at >= 5.minutes.ago
  end

  def same_kudo_giver?
    user.id == record.giver_id
  end
end
