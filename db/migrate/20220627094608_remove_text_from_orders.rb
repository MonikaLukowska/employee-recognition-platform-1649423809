class RemoveTextFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :text, :string
  end
end
