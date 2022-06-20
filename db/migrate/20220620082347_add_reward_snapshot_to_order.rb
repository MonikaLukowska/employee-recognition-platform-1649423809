class AddRewardSnapshotToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :reward_snapshot, :string
    add_column :orders, :text, :string
  end
end
