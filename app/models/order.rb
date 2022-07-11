class Order < ApplicationRecord
  enum status: { not_delivered: 0, delivered: 1 }
  serialize :reward_snapshot

  belongs_to :reward
  belongs_to :employee

  def purchase_price
    reward_snapshot.price
  end
end
