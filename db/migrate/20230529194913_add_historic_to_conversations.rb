class AddHistoricToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :historic, :text
  end
end
