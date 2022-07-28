class Order < ApplicationRecord
  enum status: { undelivered: 0, delivered: 1 }
  serialize :reward_snapshot

  belongs_to :reward
  belongs_to :employee

  scope :filtered_by_status, ->(status) { where(status: Order.statuses[status]) if status.present? }
  scope :of_an_employee, ->(employee) { where(employee: employee) }

  def purchase_price
    reward_snapshot.price
  end
end
