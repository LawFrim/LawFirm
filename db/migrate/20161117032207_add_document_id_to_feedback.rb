class AddDocumentIdToFeedback < ActiveRecord::Migration[5.0]
  def change
    add_column :feedbacks, :document_id, :integer
  end
end
