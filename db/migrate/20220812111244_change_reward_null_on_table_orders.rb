class ChangeRewardNullOnTableOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:orders, :reward_id, true)
    change_column_null(:orders, :reward_snapshot, false)
  end
end
