class CreateLegalmatters < ActiveRecord::Migration[5.0]
  def change
    create_table :legalmatters do |t|
      t.text :question

      t.timestamps
    end
  end
end
