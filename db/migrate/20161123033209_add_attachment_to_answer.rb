class AddAttachmentToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :attachment, :string
  end
end
