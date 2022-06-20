class Order < ApplicationRecord
  serialize :reward_snapshot

  belongs_to :reward
  belongs_to :employee

  def snapshot_price
    reward_snapshot.price
  end
end
