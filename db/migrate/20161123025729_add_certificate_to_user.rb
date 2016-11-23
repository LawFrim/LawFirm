class AddCertificateToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :certificate, :string
  end
end
