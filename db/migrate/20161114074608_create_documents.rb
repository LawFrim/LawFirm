class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.text :description
      t.string :client_docs
      t.integer :user_id

      t.timestamps
    end
  end
end
