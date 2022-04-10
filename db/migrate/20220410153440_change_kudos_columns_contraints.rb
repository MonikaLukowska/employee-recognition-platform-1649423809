class ChangeKudosColumnsContraints < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:kudos, :title, false)
    change_column_null(:kudos, :content, false)
    change_column_null(:kudos, :receiver_id, false)
    change_column_null(:kudos, :giver_id, false)
  end
end
