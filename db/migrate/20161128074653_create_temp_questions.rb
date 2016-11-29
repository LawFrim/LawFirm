class CreateTempQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_questions do |t|
      t.text :content
      t.string :email

      t.timestamps
    end
  end
end
