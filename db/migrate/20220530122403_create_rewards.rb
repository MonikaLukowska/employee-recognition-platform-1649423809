class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
