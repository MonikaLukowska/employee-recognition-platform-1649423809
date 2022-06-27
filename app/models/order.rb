class Order < ApplicationRecord
  serialize :reward_snapshot

  belongs_to :reward
  belongs_to :employee

  def purchase_price
    reward_snapshot.price
  end
end
