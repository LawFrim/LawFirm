class AddAnswerTypeForAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :answer_type, :string, default: 'answer'
  end
end
