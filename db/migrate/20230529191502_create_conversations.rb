class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.text :initial_question

      t.timestamps
    end
  end
end
