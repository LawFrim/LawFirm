class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.integer :question_id
      t.integer :lawyer_id
      t.integer :client_id

      t.timestamps
    end
  end
end
