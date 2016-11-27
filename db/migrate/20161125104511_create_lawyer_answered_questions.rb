class CreateLawyerAnsweredQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :lawyer_answered_questions do |t|
      t.integer :lawyer_id
      t.string :question_id

      t.timestamps
    end
  end
end
