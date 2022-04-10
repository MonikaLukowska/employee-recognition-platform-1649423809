class CreateKudos < ActiveRecord::Migration[6.1]
  def change
    create_table :kudos do |t|
      t.string :title
      t.text :content
      t.references :receiver, foreign_key: { to_table: :employees}
      t.references :giver, foreign_key: { to_table: :employees}
      t.timestamps
    end
  end
end
