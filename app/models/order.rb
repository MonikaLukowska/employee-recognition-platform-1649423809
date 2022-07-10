class Order < ApplicationRecord
  enum status: { not_delivered: 0, delivered: 1 }
  serialize :reward_snapshot

  belongs_to :reward
  belongs_to :employee

  scope :filtered_by_status, ->(status) { where(status: status) if status.present? }
  scope :of_current_employee, ->(employee) { where(employee: employee) }

  def purchase_price
    reward_snapshot.price
  end
end
