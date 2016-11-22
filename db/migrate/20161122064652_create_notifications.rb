class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :question_id
      t.integer :document_id
      t.string  :active_type
      t.datetime :read_at
      t.string :action
      t.integer :notifiable_id
      t.string :notifiable_type
      t.timestamps
    end
  end
end
