class AddAttachmentToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :attachment, :string
  end
end
