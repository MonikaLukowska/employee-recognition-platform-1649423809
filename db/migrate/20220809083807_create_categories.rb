class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title, null: false, index: { unique: true }
      t.timestamps
    end

    add_reference :rewards, :category, foreign_key: true, on_delete: :restrict
  end
end
