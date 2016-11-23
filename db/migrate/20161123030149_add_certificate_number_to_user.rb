class AddCertificateNumberToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :certificate_number, :string
  end
end
